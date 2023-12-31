//
//  MainViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 18.09.2023.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class MainViewModel: ObservableObject {
    // It might have been best to create a separate VM for the .searchable functionality, but for now i've decided to keep everything in MainViewModel since the logic isn't too complex.
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var allTrainers: [TrainerInformation]? = nil
    
    @Published var filteredTrainers: [TrainerInformation] = []
    @Published var searchTerm = ""
    
    var cancellables: Set<AnyCancellable> = []

    
    init() {
        searchTermSubscriber()
    }
    
    func searchTermSubscriber() {
        Publishers.CombineLatest($searchTerm, $allTrainers)
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .map { term, trainers -> [TrainerInformation] in
                guard let trainers = trainers else { return [] }
                return trainers.filter {
                    term.isEmpty ||
                    $0.fullname!.localizedCaseInsensitiveContains(term) ||
                    $0.gyms!.localizedCaseInsensitiveContains(term) ||
                    $0.description!.localizedCaseInsensitiveContains(term)
                }
            }
            .assign(to: &$filteredTrainers)
    }

    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                throw BeTrainerAddError.userRetrievalError
            }
            self.user = user
            // print(BeTrainerAddError.userDataLoaded.localizedDescription)
        } catch {
            // An authentication issue
            throw BeTrainerAddError.authenticationError
        }
    }
    
    func loadAllTrainers() {
        Future<[TrainerInformation], BeTrainerAddError> { promise in
            Task {
                do {
                    let allTrainerInformation = try await UserManager.shared.getAllTrainerInformation()
                    promise(.success(allTrainerInformation))
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
        }, receiveValue: { [weak self] trainerInformation in
            self?.allTrainers = trainerInformation
        })
        .store(in: &cancellables)
    } // Combine
}

//    func loadAllTrainers() async throws {
//        do {
//            let allTrainerInformation = try await UserManager.shared.getAllTrainerInformation()
//            self.allTrainers = allTrainerInformation
//
//        } catch {
//            throw BeTrainerAddError.trainerRetrievalError
//        }
//    }
