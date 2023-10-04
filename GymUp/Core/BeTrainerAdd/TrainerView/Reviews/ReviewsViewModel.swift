//
//  ReviewsViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import Foundation
import Combine

@MainActor
final class ReviewsViewModel: ObservableObject {
    
    @Published private(set) var allTrainers: [TrainerInformation]? = nil
    
    var cancellables: Set<AnyCancellable> = []
    
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
