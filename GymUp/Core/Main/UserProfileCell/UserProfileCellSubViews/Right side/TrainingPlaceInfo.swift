//
//  TrainingPlaceInfo.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct TrainingPlaceInfo: View {
    var trainer: TrainerInformation
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            IconTextRow(imageName: "dumbbell", text: "Trainer at: \(trainer.gyms ?? "")")
            Spacer()
        }
    }
}
