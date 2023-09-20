//
//  InfoRowWithRating.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct InfoRowWithRating: View {
    var valute: String
    var rating: String

    var body: some View {
        HStack(spacing: 3) {
            InfoRow(imageName: "eurosign", text: valute)
            InfoRow(imageName: "star.fill", text: rating)
        }
    }
}
