//
//  UserProfileCellReviewButtonView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 04.10.2023.
//

import SwiftUI

struct UserProfileCellReviewButtonView: View {
    @ObservedObject var addCommentVM: AddCommentViewModel
    
    var body: some View {
        VStack {
            Button(action: {
                addCommentVM.navigateToAddComment.toggle()
            }) {
                HStack {
                    Text("Add a review")
                    Image(systemName: "plus.bubble")
                        .font(.system(size: 12))
                }
                .foregroundColor(Color.white)
            }
        }
    }
}

struct UserProfileCellReviewButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileCellReviewButtonView(addCommentVM: AddCommentViewModel())
    }
}
