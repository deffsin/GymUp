//
//  View+TrainerButton.swift
//  GymUp
//
//  Created by Denis Sinitsa on 13.09.2023.
//

import Foundation
import SwiftUI

extension BeTrainerAddView {
    struct BecomeTrainerButton: View {
        @StateObject private var viewModel = BeTrainerAddViewModel()
        
        var body: some View {
            Button(action: {
                viewModel.toggleTrainerStatus() // "PAY"
            }) {
                Text("Be a trainer!")
                    .foregroundColor(Color.white)
                    .frame(width: 110, height: 65)
                    .background(Color.pink.opacity(0.8))
                    .cornerRadius(15)
            }
        }
    }
}
