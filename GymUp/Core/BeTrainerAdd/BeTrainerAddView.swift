//
//  BeTrainerAddView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

@MainActor
final class BeTrainerAddViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
        
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        self.trainer = try await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid)
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

struct BeTrainerAddView: View {
    
    @StateObject private var viewModel = BeTrainerAddViewModel()
    @State var createAccount = false
    @State var showTrainerInformation = false
    
    var body: some View {
        ZStack {
            if let user = viewModel.user {
                if user.isTrainer == false {
                    NeedToCreateAccountView(createAccount: $createAccount)
                } else {
                    TrainerView()
                }
            }
        }
        .fullScreenCover(isPresented: $createAccount) {
            FillInformationView()
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct BeTrainerAddView_Previews: PreviewProvider {
    static var previews: some View {
        BeTrainerAddView()
    }
}
