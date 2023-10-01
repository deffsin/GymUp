//
//  AuthDataResultModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let username: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.username = user.displayName // displayName??
    }
}
