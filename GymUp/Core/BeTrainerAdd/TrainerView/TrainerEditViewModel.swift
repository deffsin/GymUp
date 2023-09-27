//
//  TrainerEditViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 26.09.2023.
//

import SwiftUI
import Combine

@MainActor
final class TrainerEditViewModel: ObservableObject {
    
    @Published private(set) var trainer: TrainerInformation? = nil
    
    @Published var editInformation = false
    @Published var fullnameEdit: String = ""
    @Published var locationEdit: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
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
                print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
            case .failure(let error):
                if let error = error as? BeTrainerAddError, error == .authenticationError {
                    print("Authentication error")
                } else {
                    print("Error loading trainer info: \(error.localizedDescription)")
                }
            }
        }, receiveValue: { [weak self] trainerInfo in
            self?.trainer = trainerInfo
            self?.getInformationForEdit()
        })
        .store(in: &cancellables)
    }
    
    func getInformationForEdit() {
        self.fullnameEdit = trainer?.fullname ?? ""
        self.locationEdit = trainer?.location ?? ""
    }
}


// func loadCurrentTrainer() async throws {
//     do {
//         let authDataResult = try AuthenticationManager.shared.authenticatedUser()
//
//         guard let trainerInfo = try? await // UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
//             throw BeTrainerAddError.trainerRetrievalError
//         }
//         self.trainer = trainerInfo
//
//         try? await getInformationForEdit()
//
//
//         print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
//     } catch {
//         // An authentication issue
//         throw BeTrainerAddError.authenticationError
//     }
// }
