//
//  UserProfileCellResourcesView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellResourcesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Fitness resources:")
                .bold()
            ResourceButton(title: "Trainer programs")
                .padding(.bottom, 5)
            Divider()
            ResourceButton(title: "Nutrition for muscle gain")
                .padding([.top, .bottom], 5)
            Divider()
            ResourceButton(title: "Nutrition for weight loss")
                .padding([.top, .bottom], 5)
        }
        .padding(.horizontal, 10)
    }
    
    func ResourceButton(title: String) -> some View {
        HStack {
            Button(action: {}) {
                Text(title)
                    .foregroundColor(Color.blue)
            }
            Spacer()
        }
    }
}
