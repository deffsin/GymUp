//
//  AddReviewView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import SwiftUI

struct AddReviewView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var addReviewVM: AddReviewViewModel
    var trainer: TrainerInformation
    @Binding var isShowing: Bool

    var body: some View {
        VStack(spacing: 20) {
            ratingSection
            commentSection
            addCommentButton
        }
        .frame(width: 250)
        .task {
            try? await addReviewVM.loadCurrentUser()
        }
    }
    
    private var ratingSection: some View {
        HStack {
            Text("Rating:")
                .bold()
                .opacity(0.8)
            RatingView(rating: $addReviewVM.rating)
            Spacer()
        }
        .padding(.top, 30)
    }
    
    private var commentSection: some View {
        VStack(spacing: 7) {
            HStack {
                Text("Write a review:")
                    .opacity(0.6)
                Spacer()
            }
            
            TextEditor(text: $addReviewVM.addReview)
                .padding([.horizontal, .vertical], 5)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }

    private var addCommentButton: some View {
        Button(action: {
            addReviewVM.addReviewToUser(toUserId: trainer.userDocId!, fullname: addReviewVM.user?.username ?? "", description: addReviewVM.addReview, rating: addReviewVM.rating)
            dismiss()
        }) {
            Text("Add comment")
                .frame(width: 130, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(15)
                .opacity(addReviewVM.showButton ? 1.0 : 0.5)
                .shadow(color: addReviewVM.showButton ? .black : .black.opacity(0.5), radius: 3)
        }
        .disabled(!addReviewVM.showButton)
    }
}
