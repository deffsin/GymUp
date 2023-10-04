//
//  FillInformationViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import SwiftUI
import Combine

@MainActor
final class FillInformationViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    @Published var isAddingInformation = false

    // username?
    // photo?
    @Published var email: String = ""
    @Published var description: String = ""
    @Published var location: String = ""
    @Published var gyms: String = ""
    @Published var phoneNumber: String = ""
    @Published var webLink: String = ""
    @Published var instagram: String = ""
    @Published var facebook: String = ""
    @Published var linkedIn: String = ""
    @Published var rating: Int = 0 // Double!
    @Published var reviews: Int = 0 // Int! + it should be [] or {} in the Firebase(not for now)?
    @Published var price: String = "" // String!
    
    @Published var showButton: Bool = false
    @Published var emailIsValid: Bool = false
    @Published var descriptionIsValid: Bool = false
    @Published var locationIsValid: Bool = false
    @Published var gymsIsValid: Bool = false
    @Published var phoneNumberIsValid: Bool = false
    @Published var priceIsValid: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addEmailSubscriber()
        addDescriptionSubscriber()
        addLocationSubscriber()
        addGymsSubscriber()
        addPhoneNumberSubscriber()
        addPriceSubscriber()
        addButtonSubscriber()
    }
    
    func addEmailSubscriber() {
        $email
            .map { (text) -> Bool in
                if text.contains("@") {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.emailIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addDescriptionSubscriber() {
        $description
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.descriptionIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addLocationSubscriber() {
        $location
            .map { (text) -> Bool in
                let regex = "^[a-zA-Z\\s-',]+$"
                let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
                return predicate.evaluate(with: text)
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.locationIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addGymsSubscriber() {
        $gyms
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.gymsIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addPhoneNumberSubscriber() {
        $phoneNumber
            .map { (text) -> Bool in
                if text.contains("+") {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.phoneNumberIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addPriceSubscriber() {
        $price
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.priceIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        let combineLatestFirstFour = Publishers.CombineLatest3($emailIsValid, $descriptionIsValid, $locationIsValid)
            .eraseToAnyPublisher()
        
        let combineLatestLastThree = Publishers.CombineLatest3($gymsIsValid, $phoneNumberIsValid, $priceIsValid)
            .eraseToAnyPublisher()

        let combineFinal = Publishers.CombineLatest(combineLatestFirstFour, combineLatestLastThree)
            .map { (firstFour, lastThree) in
                return (firstFour.0, firstFour.1, firstFour.2, lastThree.0, lastThree.1, lastThree.2)
            }
            .eraseToAnyPublisher()
            
        combineFinal
            .debounce(for: .seconds(0.6), scheduler: DispatchQueue.main)
            .sink { [weak self] (emailIsValid, descriptionIsValid, locationIsValid, gymsIsValid, phoneNumberIsValid, priceIsValid) in
                guard let self = self else { return }
                if emailIsValid && descriptionIsValid && locationIsValid && gymsIsValid && phoneNumberIsValid && priceIsValid {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }

    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func addTrainerAllInformation(fullname: String, phoneNumber: String, email: String, description: String, location: String, gyms: String, webLink: String, instagram: String, facebook: String, linkedIn: String, rating: Int, reviews: Int, price: String) {
        isAddingInformation = true
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.addTrainerAllInformation(userId: authDataResult.uid, userDocId: user!.userId, fullname: fullname, phoneNumber: phoneNumber, email: email, description: description, location: location, gyms: gyms, webLink: webLink, instagram: instagram, facebook: facebook, linkedIn: linkedIn, rating: rating, reviews: reviews, price: price)
                isAddingInformation = false
        }
    }
    
    func toggleTrainerStatus() {
        guard let user else { return }
        let currentValue = user.isTrainer ?? false // some issue with log out, i can fix it later
        Task {
            try await UserManager.shared.updateUserTrainer(userId: user.userId, isTrainer: !currentValue)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
}
