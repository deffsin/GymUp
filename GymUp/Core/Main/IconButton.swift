//
//  IconButton.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct IconButton: View {
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 20))
        }
    }
}
