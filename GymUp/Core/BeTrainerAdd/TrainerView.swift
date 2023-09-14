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
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack {
                        VStack {
                            if let trainer = viewModel.trainer {
                                Text(trainer.fullname ?? "")
                                Text(trainer.description ?? "")
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                try? await viewModel.loadCurrentUser()
            }

            .task {
                try? await viewModel.loadCurrentUser()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("My profile")
                    .font(.system(size: 24))
            }
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
