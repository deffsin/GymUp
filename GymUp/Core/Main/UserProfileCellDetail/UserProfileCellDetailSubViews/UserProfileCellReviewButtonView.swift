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
                Text("Add a review")
            }
        }
    }
}

struct UserProfileCellReviewButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileCellReviewButtonView(addCommentVM: AddCommentViewModel())
    }
}
