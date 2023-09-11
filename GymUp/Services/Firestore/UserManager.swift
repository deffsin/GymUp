//
//  UserManager.swift
//  GymUp
//
//  Created by Denis Sinitsa on 04.09.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TrainerInformation: Codable {
    let id: String
    let fullname: String?
    let description: String?
    let email: String?
    let phoneNumber: String?
    let instagram: String?
    let facebook: String?
    let webLink: String?
    
    init(auth: AuthDataResultModel) {
        self.id = auth.uid
        self.fullname = nil
        self.description = nil
        self.email = nil
        self.phoneNumber = nil
        self.instagram = nil
        self.facebook = nil
        self.webLink = nil
    }
    
    init(
    id: String,
    fullname: String? = nil,
    description: String? = nil,
    email: String? = nil,
    phoneNumber: String? = nil,
    instagram: String? = nil,
    facebook: String? = nil,
    webLink: String? = nil
    
    ) {
        self.id = id
        self.fullname = fullname
        self.description = description
        self.email = email
        self.phoneNumber = phoneNumber
        self.instagram = instagram
        self.facebook = facebook
        self.webLink = webLink

    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullname = "fullname"
        case description = "description"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case instagram = "instagram"
        case facebook = "facebook"
        case webLink = "web_link" // ???
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.fullname = try container.decode(String.self, forKey: .fullname)
        self.description = try container.decode(String.self, forKey: .description)
        self.email = try container.decode(String.self, forKey: .email)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.instagram = try container.decode(String.self, forKey: .instagram)
        self.facebook = try container.decode(String.self, forKey: .facebook)
        self.webLink = try container.decode(String.self, forKey: .webLink)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.fullname, forKey: .fullname)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
        try container.encode(self.instagram, forKey: .instagram)
        try container.encode(self.facebook, forKey: .facebook)
        try container.encode(self.webLink, forKey: .webLink)
    }
}

//

struct Movie: Codable {
    let id: String
    let title: String
    let isPopular: Bool
}

//

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
    
//    func togglePremiumStatus() -> DBUser {
//        let currentValue = isPremium ?? false
//        return DBUser(
//            userId: userId,
//            email: email,
//            dataCreated: dataCreated,
//            isPremium: !currentValue)
//    }
    
//    mutating func togglePremiumStatus() {
//        let currentValue = isPremium ?? false
//        isPremium = !currentValue
//    }
    
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

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    private func trainerInformationCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("trainer_information")
    }
    
    private func trainerInformationDocument(userId: String, trainerInformationId: String) -> DocumentReference {
        trainerInformationCollection(userId: userId).document(trainerInformationId)
    }
    
    private let encoder: Firestore.Encoder = { // encode перед созданием юзера и добавлением какого либо поля
        let encoder = Firestore.Encoder()
        // encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let decoder: Firestore.Decoder = { // decode при получении данных
        let decoder = Firestore.Decoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }

    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func getFirstTrainerInformation(userId: String) async throws -> TrainerInformation? {
        let snapshot = try await trainerInformationCollection(userId: userId).getDocuments()
        let documents = snapshot.documents
        if let firstDocument = documents.first {
            return try? firstDocument.data(as: TrainerInformation.self)
        }
        return nil
    }

    
//    func getUser(userId: String) async throws -> DBUser {
//        let snapshot = try await userDocument(userId: userId).getDocument()
//
//        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
//            throw URLError(.badServerResponse)
//        }
//
//        let email = data["email"] as? String
//        let dataCreated = data["date_created"] as? Date
//
//        return DBUser(userId: userId, email: email, dataCreated: dataCreated)
//    }
    
//    func updateUserPremium(user: DBUser) async throws { // полностью переписывает весь "документ"
//        try userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder)
//    }
    
    // this function is used in the .sheet -> FillInformationView
    func addTrainerAllInformation(userId: String, fullname: String, phoneNumber: String, email: String, description: String, webLink: String, instagram: String, facebook: String) async throws {
        let document = trainerInformationCollection(userId: userId).document()
        let documentId = document.documentID
        
        let data: [String:Any] = [
            TrainerInformation.CodingKeys.id.rawValue : documentId,
            TrainerInformation.CodingKeys.fullname.rawValue : fullname,
            TrainerInformation.CodingKeys.phoneNumber.rawValue : phoneNumber,
            TrainerInformation.CodingKeys.email.rawValue : email,
            TrainerInformation.CodingKeys.description.rawValue : description,
            TrainerInformation.CodingKeys.webLink.rawValue : webLink,
            TrainerInformation.CodingKeys.instagram.rawValue : instagram,
            TrainerInformation.CodingKeys.facebook.rawValue : facebook
        ]
        try await document.setData(data, merge: false)
    }
    
    // func updateTrainerInformation
    
    func updateUserTrainer(userId: String, isTrainer: Bool) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.isTrainer.rawValue : isTrainer
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addUserPreference(userId: String, preference: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayUnion([preference])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func removeUserPreference(userId: String, preference: String) async throws {
        let data: [String:Any] = [
            DBUser.CodingKeys.preferences.rawValue : FieldValue.arrayRemove([preference])
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
    func addFavoriteMovie(userId: String, movie: Movie) async throws {
        guard let data = try? encoder.encode(movie) else {
            throw URLError(.badURL)
        }
        let dict: [String:Any] = [
            DBUser.CodingKeys.favoriteMovie.rawValue : data
        ]
        try await userDocument(userId: userId).updateData(dict)
    }
    
    func removeFavoriteMovie(userId: String) async throws {
        let data: [String:Any?] = [
            DBUser.CodingKeys.favoriteMovie.rawValue : nil
        ]
        try await userDocument(userId: userId).updateData(data as [AnyHashable : Any])
    }
}
