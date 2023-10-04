//
//  ReviewsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import SwiftUI

struct ReviewsView: View {
    @ObservedObject var reviewsVM = ReviewsViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if let trainers = reviewsVM.allTrainers {
                    ForEach(trainers, id: \.id) { trainerInfo in
                        Text(trainerInfo.id)
                    }
                }
            }
        }
        .task {
            reviewsVM.loadAllTrainers()
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
