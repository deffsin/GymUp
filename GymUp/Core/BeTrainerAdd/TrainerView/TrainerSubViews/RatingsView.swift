//
//  RatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsView: View { // ReviewsView*
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    viewModel.navigateToReviews.toggle()
                }) {
                    if let trainer = viewModel.trainer {
                        HStack(spacing: 2){
                            Text("Reviews: ")
                                .font(.system(size: 17))
                            Text("\(viewModel.allReviews?.count ?? 0)")
                                .bold()
                            Spacer()
                        }
                    }
                }
            }
            .task {
                try? await viewModel.loadCurrentUser()
                viewModel.loadAllTrainerReviews(userId: viewModel.user?.userId ?? "")
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToReviews) {
            ReviewsView()
        }
    }
}
