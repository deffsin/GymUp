//
//  UserProfileImageAndInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileImageAndInfo: View {
    var trainer: TrainerInformation
    
    var body: some View {
        VStack(spacing: 10) {
            UserProfileImage()
            
            VStack(spacing: 3){
                InfoRow(imageName: "person.text.rectangle", text: trainer.fullname ?? "")
                InfoRow(imageName: "location", text: trainer.location ?? "")
                InfoRowWithRating(valute: trainer.price ?? "", rating: String(describing: trainer.rating ?? 0))
            }
        }
        .frame(width: 110, height: 170)
        // .background(Color.red)
    }
}
