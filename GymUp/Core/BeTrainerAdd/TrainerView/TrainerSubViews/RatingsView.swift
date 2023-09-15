//
//  RatingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct RatingsView: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Text("Comments: ")
                    .font(.system(size: 17))
                Text("0")
                    .bold()
            }
            .padding()
        }
    }
}
