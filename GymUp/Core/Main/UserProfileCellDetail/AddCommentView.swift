//
//  AddCommentView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import SwiftUI

struct AddCommentView: View {
    @StateObject var addCommentVM = AddCommentViewModel()
    var trainer: TrainerInformation
    
    var body: some View {
        ZStack {
            VStack {
                Text(trainer.fullname ?? "")
                Text(trainer.id)
                Text(trainer.userDocId ?? "")
                
                TextField("Comment", text: $addCommentVM.addComment)
                
                Button(action: {
                    addCommentVM.addCommentToUser(toUserId: trainer.userDocId!, fullname: trainer.fullname!, description: addCommentVM.addComment)
                }) {
                    Text("Add comment")
                        .frame(width: 130, height: 20)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .opacity(addCommentVM.showButton ? 1.0 : 0.5)
                }
                .disabled(!addCommentVM.showButton)
            }
        }
    }
}

//struct AddCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCommentView()
//    }
//}
