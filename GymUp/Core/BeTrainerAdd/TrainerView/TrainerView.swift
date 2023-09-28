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
                    .font(.system(size: 20))
                    .foregroundColor(Color.black)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button() {
                    trainerEditVM.editInformation.toggle()
                } label: {
                    HStack(spacing: 3) {
                        Spacer()
                        Text("Edit profile")
                        Image(systemName: "pencil")
                    }
                    .font(.system(size: 16))
                    .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView(viewModel: BeTrainerAddViewModel(), trainerEditVM: TrainerEditViewModel())
    }
}
