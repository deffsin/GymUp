//
//  AuthenticationViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import Foundation
import FirebaseAuth


@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    let signInAppleHelper = SignInWithAppleHelper()
    
    func signInGoogle() async throws {
        let helper = SignInWithGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInApple() async throws {
        let helper = SignInWithAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
}
