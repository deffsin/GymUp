//
//  UserProfileCellRatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellRatingsView: View { // UserProfileCellReviewsView
    @ObservedObject var userReviewsVM: UserReviewsViewModel // i could create a separate VM for that, but i don't see the point since i only need to get the count of all the reviews
    var trainer: TrainerInformation
    
    var body: some View {
        ZStack {
            NavigationLink(destination: UserReviewsView(userReviewsVM: userReviewsVM, trainer: trainer)) {
                HStack(spacing: 2){
                    Text("Reviews: ")
                        .font(.system(size: 17))
                    Text("\(userReviewsVM.allReviews?.count ?? 0)")
                        .bold()
                    Spacer()
                }
            }
        }
    }
}
