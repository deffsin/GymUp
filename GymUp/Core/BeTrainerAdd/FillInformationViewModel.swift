//
//  FillInformationViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI

@MainActor
final class FillInformationViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var isAddingInformation = false

    // username?
    // photo?
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var description: String = ""
    @Published var gyms: [String] = []
    @Published var phoneNumber: String = ""
    @Published var webLink: String = ""
    @Published var instagram: String = ""
    @Published var facebook: String = ""
    @Published var none: String = "" // !
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func addTrainerAllInformation(fullname: String, phoneNumber: String, email: String, description: String, webLink: String, instagram: String, facebook: String) {
        isAddingInformation = true
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.addTrainerAllInformation(userId: authDataResult.uid, fullname: fullname, phoneNumber: phoneNumber, email: email, description: description, webLink: webLink, instagram: instagram, facebook: facebook)
                isAddingInformation = false
        }
    }
    
    func toggleTrainerStatus() {
        guard let user else { return }
        let currentValue = user.isTrainer ?? false // some issue with log out, i can fix it later
        Task {
            try await UserManager.shared.updateUserTrainer(userId: user.userId, isTrainer: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}
