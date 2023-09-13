//
//  TrainerView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 13.09.2023.
//

import SwiftUI

@MainActor
final class TrainerViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published private(set) var trainer: TrainerInformation? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        self.trainer = try await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid)
    }
}

struct TrainerView: View {
    @StateObject var viewModel = TrainerViewModel()
    
    var body: some View {
        ZStack {
            if let trainer = viewModel.trainer {
                VStack {
                    Text(trainer.fullname ?? "")
                    Text(trainer.description ?? "")
                }
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
