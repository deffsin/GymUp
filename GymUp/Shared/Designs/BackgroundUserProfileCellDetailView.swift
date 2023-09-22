//
//  BackgroundUserProfileCellDetailView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 23.09.2023.
//

import SwiftUI

struct BackgroundUserProfileCellDetailView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black.opacity(0.6), .pink.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

struct BackgroundUserProfileCellDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundUserProfileCellDetailView()
    }
}
