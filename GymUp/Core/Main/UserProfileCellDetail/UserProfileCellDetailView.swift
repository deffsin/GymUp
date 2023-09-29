//
//  UserProfileCellDetailView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellDetailView: View {
    var trainer: TrainerInformation
    @ObservedObject var addCommentVM: AddCommentViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundUserProfileCellDetailView()
                
                ScrollView {
                    Button(action: {
                        addCommentVM.addComment.toggle()
                    }) {
                        Text("Add a comment")
                    }
                    
                    VStack(spacing: 25) {
                        UserProfileCellInfoView(trainer: trainer)
                        UserProfileCellDetailsView(trainer: trainer)
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    VStack {
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 73)
                }
            }
        }
        .navigationDestination(isPresented: $addCommentVM.addComment) {
            AddCommentView(trainer: trainer)
        }
    }
}

// struct UserProfileCellDetailView_Previews: PreviewProvider {
//     static var previews: some View {
//         UserProfileCellDetailView()
//     }
// }
