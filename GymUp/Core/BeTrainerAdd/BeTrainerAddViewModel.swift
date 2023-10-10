//
//  BeTrainerAddViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI
import Combine

@MainActor
final class BeTrainerAddViewModel: ObservableObject { 
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
    @Published private(set) var allReviews: [TrainerReviews]? = nil
    
    @Published var navigateToReviews = false
    
    private var cancellables = Set<AnyCancellable>()
    private var cancellablesArray: Set<AnyCancellable> = []

        
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                throw BeTrainerAddError.userRetrievalError
            }
            self.user = user
            // print(BeTrainerAddError.userDataLoaded.localizedDescription)
        }
    }
    
    func loadCurrentTrainer() {
        Future<TrainerInformation, Error> { promise in
            Task {
                do {
                    let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                    guard let trainerInfo = try? await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
                        promise(.failure(BeTrainerAddError.trainerRetrievalError))
                        return
                    }
                    promise(.success(trainerInfo))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
                // print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
            case .failure(let error):
                if let error = error as? BeTrainerAddError, error == .authenticationError {
                    print("Authentication error")
                } else {
                    print("Error loading trainer info: \(error.localizedDescription)")
                }
            }
        }, receiveValue: { [weak self] trainerInfo in
            self?.trainer = trainerInfo
        })
        .store(in: &cancellables)
    }
    
    func loadAllTrainerReviews(userId: String) {
        Future<[TrainerReviews], BeTrainerAddError> { promise in
            Task {
                do {
                    let allTrainerReviews = try await UserManager.shared.getAllTrainerReviews(userId: userId)
                    promise(.success(allTrainerReviews))
                } catch {
                    promise(.failure(.trainerRetrievalError))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print("Error: \(error)")
            }
        }, receiveValue: { [weak self] trainerReviews in
            self?.allReviews = trainerReviews
        })
        .store(in: &cancellablesArray)
    } // Combine
        
    func toggleTrainerStatus() {
        guard let user = user else { return }
        let currentValue = user.isTrainer ?? false
        Task {
            do {
                try await UserManager.shared.updateUserTrainer(userId: user.userId, isTrainer: !currentValue)
                
                guard let updatedUser = try? await UserManager.shared.getUser(userId: user.userId) else {
                    throw BeTrainerAddError.updateError
                }
                self.user = updatedUser
            } catch {
                // Handle error, it can send to some publisher to notify UI about the issue
                print(error.localizedDescription)
            }
        }
    }
}
