//
//  TrainerViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI

@MainActor
final class TrainerViewModel: ObservableObject { // delete?
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        self.trainer = try await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid)
    }
}
