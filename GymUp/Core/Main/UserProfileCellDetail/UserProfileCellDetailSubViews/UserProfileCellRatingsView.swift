//
//  UserProfileCellRatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellRatingsView: View {
    var trainer: TrainerInformation
    
    var body: some View {
        HStack {
            Button(action: {}) {
                HStack(spacing: 2){
                    Text("Comments: ")
                        .font(.system(size: 17))
                    Text("\(trainer.comments ?? 0)")
                        .bold()
                    Spacer()
                }
            }
        }
    }
}
