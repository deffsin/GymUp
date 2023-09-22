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
    @Published private(set) var allTrainers: [TrainerInformation]? = nil
    
    @Published var messageView = false
    @Published var filtersView = false

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
    
    func loadAllTrainers() async throws {
        do {
            let allTrainerInformation = try await UserManager.shared.getAllTrainerInformation()
            self.allTrainers = allTrainerInformation
            
        } catch {
            throw BeTrainerAddError.trainerRetrievalError
        }
    }

}
