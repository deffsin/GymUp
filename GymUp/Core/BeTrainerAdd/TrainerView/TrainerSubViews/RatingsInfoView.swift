//
//  RatingsInfoView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsInfoView: View {
    var body: some View {
        HStack(spacing: 2) {
            Text("Rating: ")
                .font(.system(size: 17))
            Text("4.7")
                .bold()
            Image(systemName: "star.fill")
                .foregroundColor(Color.yellow)
        }
        .padding()
    }
}
