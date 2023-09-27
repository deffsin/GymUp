//
//  TrainerEditView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 26.09.2023.
//

import SwiftUI

struct TrainerEditView: View {
    @ObservedObject var viewModel: TrainerEditViewModel
    
    var body: some View {
        ZStack {
            VStack {
                if let trainer = viewModel.trainer {
                    Text(trainer.fullname ?? "")
                }
                
                TextField("", text: $viewModel.fullnameEdit)
                TextField("", text: $viewModel.locationEdit)
            }
        }
        .task {
            try? await viewModel.loadCurrentTrainer()
        }
    }
}

struct TrainerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerEditView(viewModel: TrainerEditViewModel())
    }
}
