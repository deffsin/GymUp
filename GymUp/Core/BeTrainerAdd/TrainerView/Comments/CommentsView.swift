//
//  CommentsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import SwiftUI

struct CommentsView: View {
    @ObservedObject var commentsVM = CommentsViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                if let trainers = commentsVM.allTrainers {
                    ForEach(trainers, id: \.id) { trainerInfo in
                        Text(trainerInfo.id)
                    }
                }
            }
        }
        .task {
            commentsVM.loadAllTrainers()
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
