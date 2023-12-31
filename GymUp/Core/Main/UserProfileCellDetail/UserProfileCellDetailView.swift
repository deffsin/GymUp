//
//  UserProfileCellDetailView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellDetailView: View {
    var trainer: TrainerInformation // State?
    @StateObject var addReviewVM = AddReviewViewModel()
    @StateObject var userReviewsVM = UserReviewsViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundUserProfileCellDetailView()
                
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            UserProfileCellReviewButtonView(addReviewVM: addReviewVM)
                        }
                        
                        VStack(spacing: 25) {
                            UserProfileCellInfoView(trainer: trainer)
                            UserProfileCellDetailsView(userReviewsVM: userReviewsVM, trainer: trainer)
                        }
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 20)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .task {
                userReviewsVM.loadAllTrainerReviews(userId: trainer.userDocId!)
            }
            .sheet(isPresented: $addReviewVM.showAddReview, onDismiss: {
                self.addReviewVM.addReview = ""
                self.addReviewVM.rating = 0
            }) {
                AddReviewView(addReviewVM: addReviewVM, trainer: trainer, isShowing: $addReviewVM.showAddReview)
                    // .presentationBackground(.thinMaterial) iOS 16.4
                    // .presentationCornerRadius() iOS 16.4
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }
}

// struct UserProfileCellDetailView_Previews: PreviewProvider {
//     static var previews: some View {
//         UserProfileCellDetailView()
//     }
// }
