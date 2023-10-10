//
//  UserProfileCellAboutView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellAboutView: View {
    var trainer: TrainerInformation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("About me:")
                    .bold()
                Text(trainer.description ?? "")
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, 10)
        Spacer()
    }
}
