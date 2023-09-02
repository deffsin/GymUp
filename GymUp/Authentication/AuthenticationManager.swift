//
//  AuthenticationManager.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import FirebaseAuth
import Foundation

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() {}
    
    func authenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel { // confirm password here?
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
}
