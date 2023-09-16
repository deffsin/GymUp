//
//  DetailsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        VStack {
            HStack {
                RatingsView()
                Divider()
                RatingsInfoView()
            }
            .frame(width: 300, height: 50)
            Divider()
            
            AboutMeView(viewModel: viewModel)
            
            Divider()
            ResourcesView()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.bottom, 10)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(15)
        .shadow(color: .black, radius: 8)
    }
}
