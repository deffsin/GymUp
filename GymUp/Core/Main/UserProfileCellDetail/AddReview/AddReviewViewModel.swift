//
//  AddReviewViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AddReviewViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    @Published var rating: Int = 0
    @Published var addReview = ""
    @Published var showAddReview: Bool = false
    @Published var showButton = false
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var addReviewIsValid: Bool = false
    
    init() {
        addReviewSubscriber()
        addButtonSubscriber()
    }
    
    func addReviewSubscriber() {
        $addReview
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.addReviewIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $addReviewIsValid
            .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
            .sink { [weak self] (addReviewIsValid) in
                guard let self = self else { return }
                if addReviewIsValid {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func addReviewToUser(toUserId: String, fullname: String, description: String, rating: Int) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.addTrainerReviews(userId: authDataResult.uid, toUserId: toUserId, fromUserId: user!.userId, fullname: fullname, description: description, rating: rating, dataCreated: Date())
        }
    }
    
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            
            guard let user = try? await UserManager.shared.getUser(userId: authDataResult.uid) else {
                throw BeTrainerAddError.userRetrievalError
            }
            self.user = user
            print(BeTrainerAddError.userDataLoaded.localizedDescription)
        }
    }
}
