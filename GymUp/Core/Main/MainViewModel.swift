//
//  MainViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 18.09.2023.
//

import Foundation
import SwiftUI

@MainActor
final class MainViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
        
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                throw BeTrainerAddError.userRetrievalError
            }
            self.user = user
            // print(BeTrainerAddError.userDataLoaded.localizedDescription)
            
            guard let trainerInfo = try? await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
                throw BeTrainerAddError.trainerRetrievalError
            }
            self.trainer = trainerInfo
            // print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
            
        } catch {
            // An authentication issue
            throw BeTrainerAddError.authenticationError
        }
    }
}
