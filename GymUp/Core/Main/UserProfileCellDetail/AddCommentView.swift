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
            }
        }
    }
}

//struct AddCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCommentView()
//    }
//}
