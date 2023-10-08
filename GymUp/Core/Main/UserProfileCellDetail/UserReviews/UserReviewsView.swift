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
                                HStack(spacing: 7) {
                                    Text(review.fullname!)
                                        .bold()
                                    
                                    Spacer()
                                    Text(dateFormatter.string(from: review.dataCreated!))
                                        .font(.footnote)
                                }
                                .frame(width: 235, height: 30)
                                // .background(Color.red.opacity(0.5))
                                .padding(.top, 5)
                                
                                Divider()
                                
                                VStack(spacing: 5){
                                    HStack {
                                        Text(review.description!)
                                        Spacer()
                                    }
                                    UserRatingView(userRating: review.rating!)
                                }
                                .frame(width: 235)
                                .frame(minHeight: 20)
                                .padding(.bottom, 10)
                            }
                            .frame(width: 270)
                            .frame(minHeight: 80)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.mint]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                            )
                            .shadow(color: Color.black, radius: 3)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .task {
            userReviewsVM.loadAllTrainerReviews(userId: trainer.userDocId!)
        }
    }
}
