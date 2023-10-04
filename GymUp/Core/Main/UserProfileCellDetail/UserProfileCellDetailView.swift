//
//  UserProfileCellDetailView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellDetailView: View {
    var trainer: TrainerInformation
    @StateObject var addCommentVM = AddCommentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundUserProfileCellDetailView()
                
                ScrollView {
                    VStack {
                        HStack {
                            Spacer()
                            UserProfileCellReviewButtonView(addCommentVM: addCommentVM)
                        }
                        
                        VStack(spacing: 25) {
                            UserProfileCellInfoView(trainer: trainer)
                            UserProfileCellDetailsView(trainer: trainer)
                        }
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .sheet(isPresented: $addCommentVM.navigateToAddComment, onDismiss: {
                self.addCommentVM.addComment = ""
                self.addCommentVM.rating = 0
            }) {
                AddCommentView(addCommentVM: addCommentVM, trainer: trainer, isShowing: $addCommentVM.navigateToAddComment)
                    // .presentationBackground(.thinMaterial) iOS 16.4
                    // .presentationCornerRadius() iOS 16.4
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }
}

// struct UserProfileCellDetailView_Previews: PreviewProvider {
//     static var previews: some View {
//         UserProfileCellDetailView()
//     }
// }
