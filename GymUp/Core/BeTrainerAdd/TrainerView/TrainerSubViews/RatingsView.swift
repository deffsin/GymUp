//
//  RatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        Button(action: {}) {
            if let trainer = viewModel.trainer {
                HStack {
                    Text("Comments: ")
                        .font(.system(size: 17))
                    Text("\(trainer.comments ?? 0)")
                        .bold()
                }
                .padding()
            }
        }
    }
}
