//
//  NeedToCreateAccountView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI

struct NeedToCreateAccountView: View { // for the trainer account
    @Binding var createAccount: Bool

    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Text("Now you need to create a trainer account!")
                Button {
                    createAccount.toggle()
                } label: {
                    Text("Create")
                        .bold()
                }
            }
        }
    }
}
