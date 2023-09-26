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
    
    func loadCurrentTrainer() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let trainerInfo = try? await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
                throw BeTrainerAddError.trainerRetrievalError
            }
            self.trainer = trainerInfo
            
            try? await getInformationForEdit()
            
            
            print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
        } catch {
            // An authentication issue
            throw BeTrainerAddError.authenticationError
        }
    }
    
    func getInformationForEdit() async throws {
        self.fullnameEdit = trainer?.fullname ?? ""
        self.locationEdit = trainer?.location ?? ""
    }
}
