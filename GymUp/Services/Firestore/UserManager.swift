//
//  UserManager.swift
//  GymUp
//
//  Created by Denis Sinitsa on 04.09.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let email: String?
    let dataCreated: Date?
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        var userData: [String:Any] = [
            "user_id": auth.uid,
            "date_created": Timestamp()
        ]
        if let email = auth.email {
            userData["email"] = email
        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let email = data["email"] as? String
        let dataCreated = data["date_created"] as? Date
        
        return DBUser(userId: userId, email: email, dataCreated: dataCreated)
    }
}
