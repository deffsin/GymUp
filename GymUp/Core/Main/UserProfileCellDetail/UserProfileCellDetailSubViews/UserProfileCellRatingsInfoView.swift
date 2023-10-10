//
//  UserProfileCellRatingsInfoView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellRatingsInfoView: View {
    
    @ObservedObject var userReviewsVM: UserReviewsViewModel
    var trainer: TrainerInformation
    
    var body: some View {
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
    
    var averageRating: Double {
        guard let reviews = userReviewsVM.allReviews, !reviews.isEmpty else { return 0.0 }
        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        return Double(totalRating) / Double(reviews.count)
    }
}
