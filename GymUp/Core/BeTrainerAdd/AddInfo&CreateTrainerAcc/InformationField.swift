//
//  InformationField.swift
//  GymUp
//
//  Created by Denis Sinitsa on 25.09.2023.
//

import SwiftUI

struct InformationField: View {
    
    var title: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 19))
            TextField(placeholder, text: $text)
                .padding([.horizontal, .vertical], 5)
                .frame(width: 250, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .overlay (
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.red)
                            .opacity(
                                text.count < 1 ? 0.0 :
                                    (isValid ?? false) ? 0.0 : 1.0
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .opacity(
                                (isValid ?? false) ? 1.0 : 0.0
                            )
                    }
                    .padding(.trailing, 3)
                    ,alignment: .trailing
                )
                .keyboardType(keyboardType)
            Spacer()
        }
    }
}
