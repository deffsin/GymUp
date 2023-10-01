//
//  AddCommentViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AddCommentViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    @Published var addComment = ""
    @Published var navigateToAddComment = false
    @Published var showButton = false
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var addCommentIsValid: Bool = false
    
    init() {
        addCommentSubscriber()
        addButtonSubscriber()
    }
    
    func addCommentSubscriber() {
        $addComment
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.addCommentIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $addCommentIsValid
            .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
            .sink { [weak self] (addCommentIsValid) in
                guard let self = self else { return }
                if addCommentIsValid {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
    func addCommentToUser(toUserId: String, fullname: String, description: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.addTrainerComments(userId: authDataResult.uid, toUserId: toUserId, fullname: fullname, description: description, dataCreated: Date())
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
