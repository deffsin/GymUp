//
//  UserManager.swift
//  GymUp
//
//  Created by Denis Sinitsa on 04.09.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection: CollectionReference = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    // документ другого пользователя
    private func toOtherUserDocument(toUserId: String) -> DocumentReference {
        userCollection.document(toUserId)
    }
    
    private func trainerInformationCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("trainer_information")
    }
    
    private func trainerInformationDocument(userId: String, trainerInformationId: String) -> DocumentReference {
        trainerInformationCollection(userId: userId).document(trainerInformationId)
    }
    
    private func trainerReviewsCollection(userId: String) -> CollectionReference {
        userDocument(userId: userId).collection("trainer_reviews")
    }
    
    // добавляет комментарии в аккаунт другого пользователя
    private func toOtherTrainerReviewsCollection(toUserId: String) -> CollectionReference {
        toOtherUserDocument(toUserId: toUserId).collection("trainer_reviews")
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
    
    func getAllTrainerReviews(userId: String) async throws -> [TrainerReviews] {
        do {
            let snapshot = try await trainerReviewsCollection(userId: userId).getDocuments()
            return snapshot.documents.compactMap { try? $0.data(as: TrainerReviews.self) }
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    func addTrainerReviews(userId: String, toUserId: String, fromUserId: String, fullname: String, description: String, rating: Int, dataCreated: Date) async throws {
        do {
            let document = toOtherTrainerReviewsCollection(toUserId: toUserId).document()
            let documentId = document.documentID
            
            let data: [String:Any] = [
                TrainerReviews.CodingKeys.id.rawValue : documentId,
                TrainerReviews.CodingKeys.fullname.rawValue : fullname,
                TrainerReviews.CodingKeys.toUserId.rawValue : toUserId,
                TrainerReviews.CodingKeys.fromUserId.rawValue : fromUserId,
                TrainerReviews.CodingKeys.description.rawValue : description,
                TrainerReviews.CodingKeys.rating.rawValue : rating,
                TrainerReviews.CodingKeys.dataCreated.rawValue : Date()
            ]
            try await document.setData(data, merge: false)
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    // this function is used in the .sheet -> FillInformationView
    func addTrainerAllInformation(userId: String, userDocId: String, fullname: String, phoneNumber: String, email: String, description: String, location: String, gyms: String, webLink: String, instagram: String, facebook: String, linkedIn: String, rating: Int, reviews: Int, price: String) async throws {
        do {
            let document = trainerInformationCollection(userId: userId).document()
            let documentId = document.documentID
            
            let data: [String:Any] = [
                TrainerInformation.CodingKeys.id.rawValue : documentId,
                TrainerInformation.CodingKeys.userDocId.rawValue : userDocId,
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
                TrainerInformation.CodingKeys.reviews.rawValue : reviews,
                TrainerInformation.CodingKeys.price.rawValue : price
            ]
            try await document.setData(data, merge: false)
            
        } catch {
            throw UserManagerError.connectionFailed
        }
    }
    
    func updateTrainerAllInformation(userId: String, trainerInformationId: String, newPhoneNumber: String, newEmail: String, newDescription: String, newLocation: String, newGyms: String, newWebLink: String, newInstagram: String, newFacebook: String, newLinkedIn: String, newPrice: String) async throws {
        let document = trainerInformationDocument(userId: userId, trainerInformationId: trainerInformationId)
        
        do {
            let data: [String: Any] = [
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
}
