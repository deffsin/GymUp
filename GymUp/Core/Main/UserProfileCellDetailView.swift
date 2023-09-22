//
//  UserProfileCellDetailView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 22.09.2023.
//

import SwiftUI

struct UserProfileCellDetailView: View {
    var trainer: TrainerInformation
    
    var body: some View {
        VStack {
            Text("UserProfileCellDetailView")
            Text(trainer.fullname ?? "")
        }
    }
}

// struct UserProfileCellDetailView_Previews: PreviewProvider {
//     static var previews: some View {
//         UserProfileCellDetailView()
//     }
// }
