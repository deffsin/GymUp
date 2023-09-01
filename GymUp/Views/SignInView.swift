//
//  SignInView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(10)
                    
                    Button(action: {
                        viewModel.singIn()
                    }) {
                        Text("Sign In")
                            .font(.caption)
                            .foregroundColor(Color.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                }
                .textInputAutocapitalization(.never)
                .padding()
            }
            .navigationTitle("Sign In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
