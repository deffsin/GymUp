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
        ZStack {
            HStack(spacing: 2) {
                Spacer()
                Text("Rating: ")
                    .font(.system(size: 17))
                
                Text(String(format: "%.1f", averageRating))
                    .bold()
                
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            }
        }
    }

    var averageRating: Double {
        guard let reviews = viewModel.allReviews, !reviews.isEmpty else { return 0.0 }
        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        return Double(totalRating) / Double(reviews.count)
    }
}
