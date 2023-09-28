//
//  UserManager.swift
//  GymUp
//
//  Created by Denis Sinitsa on 04.09.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

//

struct Movie: Codable {
    let id: String
    let title: String
    let isPopular: Bool
}

//


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
        do {
            try userDocument(userId: user.userId).setData(from: user, merge: false)
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    
    func getUser(userId: String) async throws -> DBUser {
        do {
            let user = try await userDocument(userId: userId).getDocument(as: DBUser.self)
            return user
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }

    
    func getFirstTrainerInformation(userId: String) async throws -> TrainerInformation? {
        do {
            let snapshot = try await trainerInformationCollection(userId: userId).getDocuments()
            let documents = snapshot.documents
            if let firstDocument = documents.first {
                return try? firstDocument.data(as: TrainerInformation.self)
            }
            return nil
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    func getAllTrainerInformation() async throws -> [TrainerInformation] {
        var allTrainerInfos: [TrainerInformation] = []
        
        do {
            let snapshot = try await userCollection.getDocuments()
            let userDocuments = snapshot.documents
            
            for userDoc in userDocuments {
                let userId = userDoc.documentID
                
                if let trainerInfo = try? await getFirstTrainerInformation(userId: userId) {
                    allTrainerInfos.append(trainerInfo)
                }
            }
            return allTrainerInfos
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    // this function is used in the .sheet -> FillInformationView
    func addTrainerAllInformation(userId: String, fullname: String, phoneNumber: String, email: String, description: String, location: String, gyms: String, webLink: String, instagram: String, facebook: String, linkedIn: String, rating: Int, comments: Int, price: String) async throws {
        do {
            let document = trainerInformationCollection(userId: userId).document()
            let documentId = document.documentID
            
            let data: [String:Any] = [
                TrainerInformation.CodingKeys.id.rawValue : documentId,
                TrainerInformation.CodingKeys.fullname.rawValue : fullname,
                TrainerInformation.CodingKeys.phoneNumber.rawValue : phoneNumber,
                TrainerInformation.CodingKeys.email.rawValue : email,
                TrainerInformation.CodingKeys.description.rawValue : description,
                TrainerInformation.CodingKeys.location.rawValue : location,
                TrainerInformation.CodingKeys.gyms.rawValue : gyms,
                TrainerInformation.CodingKeys.webLink.rawValue : webLink,
                TrainerInformation.CodingKeys.instagram.rawValue : instagram,
                TrainerInformation.CodingKeys.facebook.rawValue : facebook,
                TrainerInformation.CodingKeys.linkedIn.rawValue : linkedIn,
                TrainerInformation.CodingKeys.rating.rawValue : rating,
                TrainerInformation.CodingKeys.comments.rawValue : comments,
                TrainerInformation.CodingKeys.price.rawValue : price
            ]
            try await document.setData(data, merge: false)
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    func updateTrainerAllInformation(userId: String, trainerInformationId: String, newFullname: String, newPhoneNumber: String, newEmail: String, newDescription: String, newLocation: String, newGyms: String, newWebLink: String, newInstagram: String, newFacebook: String, newLinkedIn: String, newPrice: String) async throws {
        let document = trainerInformationDocument(userId: userId, trainerInformationId: trainerInformationId)
        
        do {
            let data: [String: Any] = [
                TrainerInformation.CodingKeys.fullname.rawValue: newFullname,
                TrainerInformation.CodingKeys.phoneNumber.rawValue : newPhoneNumber,
                TrainerInformation.CodingKeys.email.rawValue : newEmail,
                TrainerInformation.CodingKeys.description.rawValue : newDescription,
                TrainerInformation.CodingKeys.location.rawValue : newLocation,
                TrainerInformation.CodingKeys.gyms.rawValue : newGyms,
                TrainerInformation.CodingKeys.webLink.rawValue : newWebLink,
                TrainerInformation.CodingKeys.instagram.rawValue : newInstagram,
                TrainerInformation.CodingKeys.facebook.rawValue : newFacebook,
                TrainerInformation.CodingKeys.linkedIn.rawValue : newLinkedIn,
                TrainerInformation.CodingKeys.price.rawValue : newPrice
            ]
            try await document.updateData(data)
    
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
        
    func updateUserTrainer(userId: String, isTrainer: Bool) async throws {
        do {
            let data: [String:Any] = [
                DBUser.CodingKeys.isTrainer.rawValue : isTrainer
            ]
            try await userDocument(userId: userId).updateData(data)
            
        } catch {
            throw UserManagerError.connectionFailed
        }
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
