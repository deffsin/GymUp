//
//  AboutMeView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct AboutMeView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                if let trainer = viewModel.trainer {
                    Text("About me:")
                        .bold()
                    Text(trainer.description ?? "")
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            Spacer()
        }
    }
}
