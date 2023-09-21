//
//  UserProfileImage.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileImage: View {
    var body: some View {
        Image("me")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 90, height: 105)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))
            .shadow(color: .black, radius: 2)
    }
}
