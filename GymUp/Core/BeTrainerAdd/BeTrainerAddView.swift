//
//  BeTrainerAddView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

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
        .sheet(isPresented: $createAccount, onDismiss: {
            Task {
                try? await viewModel.loadCurrentUser()
            }
        }) {
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
