//
//  TrainerView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 13.09.2023.
//

import SwiftUI

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
