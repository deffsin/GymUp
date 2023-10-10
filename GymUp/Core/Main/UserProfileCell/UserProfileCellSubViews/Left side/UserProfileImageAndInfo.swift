//
//  UserProfileImageAndInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileImageAndInfo: View {
    
    @ObservedObject var userProfileCellVM: UserProfileCellViewModel
    var trainer: TrainerInformation
    
    var body: some View {
        VStack(spacing: 10) {
            UserProfileImage()
            
            VStack(spacing: 3){
                InfoRow(imageName: "person.text.rectangle", text: trainer.fullname ?? "")
                InfoRow(imageName: "location", text: trainer.location ?? "")
                InfoRowWithRating(valute: trainer.price ?? "", rating: String(format: "%.1f", averageRating))
            }
        }
        .frame(width: 110, height: 170)
        // .background(Color.red)
    }
    
    var averageRating: Double {
        guard let reviews = userProfileCellVM.allReviews, !reviews.isEmpty else { return 0.0 }
        let totalRating = reviews.compactMap { $0.rating }.reduce(0, +)
        return Double(totalRating) / Double(reviews.count)
    }
}
