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
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
