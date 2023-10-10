//
//  UserProfileCellDetailsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellDetailsView: View {
    @ObservedObject var userReviewsVM: UserReviewsViewModel
    var trainer: TrainerInformation
    
    var body: some View {
        VStack {
            HStack {
                UserProfileCellRatingsView(userReviewsVM: userReviewsVM, trainer: trainer)
                Divider()
                UserProfileCellRatingsInfoView(userReviewsVM: userReviewsVM, trainer: trainer)
            }
            .frame(width: 280, height: 50)
            Divider()
            
            UserProfileCellAboutView(trainer: trainer)
            
            Divider()
            
            UserProfileCellResourcesView()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.bottom, 10)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(15)
        .shadow(color: .black, radius: 8)
    }
}
