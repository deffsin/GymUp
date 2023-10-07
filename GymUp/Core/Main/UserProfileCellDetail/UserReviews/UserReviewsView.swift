//
//  UserReviewsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 07.10.2023.
//

import SwiftUI

struct UserReviewsView: View {
    @StateObject var userReviewsVM = UserReviewsViewModel()
    var trainer: TrainerInformation
    
    var body: some View {
        ZStack {
            VStack {
                Text("UserReviewsView")
                if let userReviews = userReviewsVM.allReviews {
                    ForEach(userReviews, id: \.id) { review in
                        Text(review.description!)
                    }
                }
            }
        }
        .task {
            userReviewsVM.loadAllTrainerReviews(userId: trainer.userDocId!)
        }
    }
}
