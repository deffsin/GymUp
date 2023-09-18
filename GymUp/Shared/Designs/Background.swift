//
//  Background.swift
//  GymUp
//
//  Created by Denis Sinitsa on 18.09.2023.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black.opacity(0.9), .mint.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
