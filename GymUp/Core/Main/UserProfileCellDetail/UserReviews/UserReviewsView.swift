//
//  UserReviewsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 07.10.2023.
//

import SwiftUI

struct UserReviewsView: View {
    @StateObject var userReviewsVM = UserReviewsViewModel() // возможно стоит создавать StateObject не прямо тут
    var trainer: TrainerInformation
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var body: some View {
        ZStack {
            BackgroundUserProfileCellDetailView()
            
            ScrollView {
                if let userReviews = userReviewsVM.allReviews {
                    ForEach(userReviews, id: \.id) { review in
                        VStack {
                            VStack {
                                ZStack {
                                    UserRatingView(userRating: review.rating!)

                                    HStack(spacing: 7) {
                                        Text(review.fullname!)
                                            .bold()
                                        
                                        Spacer()
                                        Text(dateFormatter.string(from: review.dataCreated!))
                                            .font(.footnote)
                                    }
                                    .frame(width: 220, height: 30)
                                    .background(Color.red.opacity(0.5))
                                    .padding(.top, 5)
                                }
                                
                                Divider()
                                
                                HStack {
                                    Text(review.description!)
                                    Spacer()
                                }
                                .frame(width: 220)
                                .frame(minHeight: 20)
                                .padding(.bottom, 5)
                            }
                            .frame(width: 240)
                            .frame(minHeight: 80)
                            .background(Color.green.opacity(0.5))
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
        .task {
            userReviewsVM.loadAllTrainerReviews(userId: trainer.userDocId!)
        }
    }
}
