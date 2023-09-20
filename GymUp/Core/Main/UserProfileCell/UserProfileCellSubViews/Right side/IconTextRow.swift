//
//  IconTextRow.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct IconTextRow: View {
    var imageName: String
    var text: String

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            Image(systemName: imageName)
                .opacity(0.6)
                .font(.system(size: 12))
            Text(text)
                .font(.system(size: 13))
        }
    }
}
