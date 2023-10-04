//
//  RatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    viewModel.navigateToComments.toggle()
                }) {
                    if let trainer = viewModel.trainer {
                        HStack(spacing: 2){
                            Text("Comments: ")
                                .font(.system(size: 17))
                            Text("\(trainer.reviews ?? 0)")
                                .bold()
                            Spacer()
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToComments) {
            CommentsView()
        }
    }
}
