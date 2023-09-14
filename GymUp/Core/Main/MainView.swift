//
//  MainView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Main")
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                try? await viewModel.loadCurrentUser()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
