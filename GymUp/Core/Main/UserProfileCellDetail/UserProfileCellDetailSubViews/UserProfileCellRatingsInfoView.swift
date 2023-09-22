//
//  UserProfileCellRatingsInfoView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellRatingsInfoView: View {
    var trainer: TrainerInformation
    
    var body: some View {
        HStack(spacing: 2) {
            Spacer()
            Text("Rating: ")
                .font(.system(size: 17))
            Text("\(trainer.rating ?? 0)")
                .bold()
            Image(systemName: "star.fill")
                .foregroundColor(Color.yellow)
        }
    }
}
