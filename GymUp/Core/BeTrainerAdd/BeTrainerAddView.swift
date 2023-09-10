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
    
    func loadCurrentUser() async throws { 
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func toggleTrainerStatus() {
        guard let user else { return }
        let currentValue = user.isTrainer ?? false
        Task {
            try await UserManager.shared.updateUserTrainer(userId: user.userId, isTrainer: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
}

struct BeTrainerAddView: View {
    
    @StateObject private var viewModel = BeTrainerAddViewModel()
    @State var createAccount = false
    
    var body: some View {
        ZStack {
            if let user = viewModel.user {
                VStack {
                    Spacer()
                    
                    if user.isTrainer == true {
                        VStack(spacing: 15) {
                            Text("Now you need to create a trainer account!")
                            Button {
                                createAccount.toggle()
                            } label: {
                                Text("Create")
                                    .bold()
                            }
                            
                        }
                    } else {
                        Button(action: {
                            viewModel.toggleTrainerStatus()
                        }) {
                            Text("Be a trainer!")
                                .foregroundColor(Color.white)
                                .frame(width: 110, height: 65)
                                .background(Color.pink.opacity(0.8))
                                .cornerRadius(15)
                        }
                    }
                }
                .sheet(isPresented: $createAccount) {
                    FillInformationView()
                }
            }
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
