//
//  RatingsInfoView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsInfoView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        HStack(spacing: 2) {
            Spacer()
            if let trainer = viewModel.trainer {
                Text("Rating: ")
                    .font(.system(size: 17))
                Text("\(trainer.rating ?? 0)")
                    .bold()
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
        }
    }
}
