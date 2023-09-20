//
//  UserProfileImageAndInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileImageAndInfo: View {
    var body: some View {
        VStack(spacing: 10) {
            // Spacer()
            UserProfileImage()
            
            VStack(spacing: 3){
                InfoRow(imageName: "person.text.rectangle", text: "Denis")
                InfoRow(imageName: "location", text: "Tallinn, Estonia")
                InfoRowWithRating(valute: "20", rating: "4.7")
            }
            //Spacer()
        }
        .frame(width: 110, height: 170)
        // .background(Color.red)
    }
}
