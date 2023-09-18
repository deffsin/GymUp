//
//  BeTrainerAddView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

struct BeTrainerAddView: View {
    
    @ObservedObject var viewModel: BeTrainerAddViewModel
    @State var showTrainerInformation = false
    
    var body: some View {
        ZStack {
            if let user = viewModel.user {
                if user.isTrainer == false {
                    NeedToCreateAccountView(viewModel: viewModel)
                } else {
                    TrainerView(viewModel: viewModel)
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
        BeTrainerAddView(viewModel: BeTrainerAddViewModel())
    }
}
