//
//  UserProfileCell.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileCell: View {
    var trainer: TrainerInformation
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(spacing: 10){
                        UserProfileImageAndInfo(trainer: trainer)
                    }
                    .frame(width: 110, height: 180)
                    // .background(Color.red)
                    
                    VStack(spacing: 8){
                        TrainingPlaceInfo(trainer: trainer)
                        TrainerExperienceInfo(trainer: trainer)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 160)
                    // .background(Color.red)
                    
                    Spacer()
                }
                .padding([.horizontal, .vertical], 7)
            }
            .frame(maxWidth: .infinity, minHeight: 170)
            .background(Color.white.opacity(0.9))
            .foregroundColor(Color.black)
            .cornerRadius(15)
            .shadow(color: .black, radius: 8)
        }
    }
}

// struct UserProfileCell_Previews: PreviewProvider {
//     static var previews: some View {
//         UserProfileCell(viewModel: MainViewModel())
//     }
// }
