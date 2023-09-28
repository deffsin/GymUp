//
//  TrainerView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 13.09.2023.
//

import SwiftUI

struct TrainerView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    @ObservedObject var trainerEditVM: TrainerEditViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                ScrollView {
                    
                    Button() {
                        trainerEditVM.editInformation.toggle()
                    } label: {
                        Text("Edit profile")
                            .padding()
                            .background(Color.green.opacity(0.7))
                    }
                    
                    VStack(spacing: 25) {
                        UserInfoView(viewModel: viewModel)
                        DetailsView(viewModel: viewModel)
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 73)
                }
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                try? await viewModel.loadCurrentUser()
                viewModel.loadCurrentTrainer()
            }
            .sheet(isPresented: $trainerEditVM.editInformation, onDismiss: {
                Task {
                    viewModel.loadCurrentTrainer()
                }
            }) {
                TrainerEditView(viewModel: TrainerEditViewModel())
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("My profile")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView(viewModel: BeTrainerAddViewModel(), trainerEditVM: TrainerEditViewModel())
    }
}
