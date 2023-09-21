//
//  TrainerExperienceInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct TrainerExperienceInfo: View {
    var trainer: TrainerInformation
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                IconTextRow(imageName: "info.bubble", text: trainer.description ?? "")
                Spacer()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
