//
//  AddCommentView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import SwiftUI

struct AddCommentView: View {
    @ObservedObject var addCommentVM: AddCommentViewModel
    var trainer: TrainerInformation
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            if isShowing {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                VStack {
                    TextField("Comment", text: $addCommentVM.addComment)
                    addCommentButton
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .padding(.horizontal, 30)
                .background(Color.white)
                .cornerRadius(16)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .padding(.horizontal, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut, value: isShowing)
        .task {
            try? await addCommentVM.loadCurrentUser()
        }
    }
    
    private var addCommentButton: some View {
        Button(action: {
            addCommentVM.addCommentToUser(toUserId: trainer.userDocId!, fullname: addCommentVM.user?.username ?? "", description: addCommentVM.addComment)
        }) {
            Text("Add comment")
                .frame(width: 130, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
                .opacity(addCommentVM.showButton ? 1.0 : 0.5)
        }
        .disabled(!addCommentVM.showButton)
    }
}


//struct AddCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCommentView()
//    }
//}
