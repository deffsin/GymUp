//
//  InformationFieldWithoutMarks.swift
//  GymUp
//
//  Created by Denis Sinitsa on 27.09.2023.
//

import SwiftUI

struct InformationFieldWithoutMarks: View {
    
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
                .keyboardType(keyboardType)
            Spacer()
        }
    }
}
