//
//  UserProfileCellViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI
import Combine

@MainActor
final class UserProfileCellViewModel: ObservableObject {
    
    @Published private(set) var allReviews: [TrainerReviews]? = nil
    
    @Published var navigateToReviews = false
    
    private var cancellablesArray: Set<AnyCancellable> = []
    
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
}
