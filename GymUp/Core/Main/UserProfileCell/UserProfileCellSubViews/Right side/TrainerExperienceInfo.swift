//
//  TrainerExperienceInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct TrainerExperienceInfo: View {
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                IconTextRow(imageName: "info.bubble", text: "With 6 years of experience in the gym, I've honed techniques that deliver results. My approach is tailored to your needs, ensuring that every workout is effective and engaging. Let's reach your fitness goals together")
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
