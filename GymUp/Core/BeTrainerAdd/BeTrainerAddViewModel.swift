//
//  BeTrainerAddViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI

@MainActor
final class BeTrainerAddViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
        
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
        
    func loadCurrentTrainer() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let trainerInfo = try? await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
                throw BeTrainerAddError.trainerRetrievalError
            }
            self.trainer = trainerInfo
            
            print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
        } catch {
            // An authentication issue
            throw BeTrainerAddError.authenticationError
        }
    }
        
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
