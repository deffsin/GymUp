//
//  DBUserModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import Foundation


struct DBUser: Codable {
    let userId: String
    let email: String?
    let username: String?
    let dataCreated: Date?
    let isTrainer: Bool?
    let preferences: [String]?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.username = auth.username
        self.dataCreated = Date()
        self.isTrainer = false
        self.preferences = nil
    }
    
    init(
    userId: String,
    email: String? = nil,
    username: String? = nil,
    dataCreated: Date? = nil,
    isTrainer: Bool? = nil,
    preferences: [String]? = nil
    ) {
        self.userId = userId
        self.email = email
        self.username = username
        self.dataCreated = dataCreated
        self.isTrainer = isTrainer
        self.preferences = preferences
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case username = "username"
        case dataCreated = "data_created"
        case isTrainer = "user_isTrainer"
        case preferences = "preferences"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
        self.isTrainer = try container.decodeIfPresent(Bool.self, forKey: .isTrainer)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.username, forKey: .username)
        try container.encodeIfPresent(self.dataCreated, forKey: .dataCreated)
        try container.encodeIfPresent(self.isTrainer, forKey: .isTrainer)
    }
}
