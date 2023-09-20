//
//  MainView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

struct MainView: View {
    // i think i should to create another view model here, not the same like in the BeTrainerAdd
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ZStack {
                    VStack {
                        VStack {
                            Text("Main")
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                // try? await viewModel.loadCurrentUser()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
