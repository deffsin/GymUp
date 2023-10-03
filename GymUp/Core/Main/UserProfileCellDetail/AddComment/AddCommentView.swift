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
            VStack(spacing: 20) {
                Text("Rating: 1, 2, 3, 4, 5")
                
                TextEditor(text: $addCommentVM.addComment)
                    .padding([.horizontal, .vertical], 5)
                    .frame(width: 250, height: 80)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    }
                
                addCommentButton
            }
        }
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
                .background(Color.pink)
                .cornerRadius(15)
                .opacity(addCommentVM.showButton ? 1.0 : 0.5)
                .shadow(color: addCommentVM.showButton ? .black : .black.opacity(0.5), radius: 3)
        }
        .disabled(!addCommentVM.showButton)
    }
}


//struct AddCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCommentView()
//    }
//}
