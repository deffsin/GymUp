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
    let dataCreated: Date?
    let isTrainer: Bool?
    let preferences: [String]?
    let favoriteMovie: Movie?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.dataCreated = Date()
        self.isTrainer = false
        self.preferences = nil
        self.favoriteMovie = nil
    }
    
    init(
    userId: String,
    email: String? = nil,
    dataCreated: Date? = nil,
    isTrainer: Bool? = nil,
    preferences: [String]? = nil,
    favoriteMovie: Movie? = nil
    ) {
        self.userId = userId
        self.email = email
        self.dataCreated = dataCreated
        self.isTrainer = isTrainer
        self.preferences = preferences
        self.favoriteMovie = favoriteMovie
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case dataCreated = "data_created"
        case isTrainer = "user_isTrainer"
        case preferences = "preferences"
        case favoriteMovie = "favorite_movie"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
        self.isTrainer = try container.decodeIfPresent(Bool.self, forKey: .isTrainer)
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
        self.favoriteMovie = try container.decodeIfPresent(Movie.self, forKey: .favoriteMovie)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.dataCreated, forKey: .dataCreated)
        try container.encodeIfPresent(self.isTrainer, forKey: .isTrainer)
        try container.encodeIfPresent(self.favoriteMovie, forKey: .favoriteMovie)
    }
}
