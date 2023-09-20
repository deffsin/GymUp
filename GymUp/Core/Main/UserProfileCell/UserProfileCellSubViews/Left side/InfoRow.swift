//
//  InfoRow.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct InfoRow: View {
    var imageName: String
    var text: String

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: imageName)
                .opacity(0.6)
                .font(.system(size: 10))
            
            Text(text)
                .font(.system(size: 11))
                .bold()
            Spacer()
        }
    }
}
