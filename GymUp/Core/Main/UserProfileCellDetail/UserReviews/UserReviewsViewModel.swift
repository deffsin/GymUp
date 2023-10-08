//
//  UserReviewsViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 07.10.2023.
//

import Foundation
import Combine

@MainActor
final class UserReviewsViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    @Published private(set) var allReviews: [TrainerReviews]? = nil
        
    var cancellables: Set<AnyCancellable> = []
    
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
        .store(in: &cancellables)
    } // Combine
    
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                throw BeTrainerAddError.userRetrievalError
            }
            self.user = user
            print(BeTrainerAddError.userDataLoaded.localizedDescription)
        }
    }
}
