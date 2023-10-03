//
//  TrainerEditViewModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 26.09.2023.
//

import SwiftUI
import Combine

@MainActor
final class TrainerEditViewModel: ObservableObject {
    
    @Published private(set) var trainer: TrainerInformation? = nil
    
    @Published var editInformation = false
    @Published var emailEdit: String = ""
    @Published var descriptionEdit: String = ""
    @Published var locationEdit: String = ""
    @Published var gymsEdit: String = ""
    @Published var phoneNumberEdit: String = ""
    @Published var priceEdit: String = ""
    @Published var instagramEdit: String = ""
    @Published var facebookEdit: String = ""
    @Published var linkedinEdit: String = ""
    @Published var webLinkEdit: String = ""
    @Published var test: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var showButton: Bool = false
    @Published var emailIsValid: Bool = false
    @Published var descriptionIsValid: Bool = false
    @Published var locationIsValid: Bool = false
    @Published var gymsIsValid: Bool = false
    @Published var phoneNumberIsValid: Bool = false
    @Published var priceIsValid: Bool = false
    @Published var instagramIsValid: Bool = false
    @Published var facebookIsValid: Bool = false
    @Published var linkedinIsValid: Bool = false
    @Published var webLinkIsValid: Bool = false
    
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
        $emailEdit
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
        $descriptionEdit
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.descriptionIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addLocationSubscriber() {
        $locationEdit
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
        $gymsEdit
            .map { (text) -> Bool in
                return !text.isEmpty
            }
            .sink(receiveValue: { [weak self] (isValid) in
                self?.gymsIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addPhoneNumberSubscriber() {
        $phoneNumberEdit
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
        $priceEdit
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
    
    func loadCurrentTrainer() {
        Future<TrainerInformation, Error> { promise in
            Task {
                do {
                    let authDataResult = try AuthenticationManager.shared.authenticatedUser()
                    guard let trainerInfo = try? await UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
                        promise(.failure(BeTrainerAddError.trainerRetrievalError))
                        return
                    }
                    promise(.success(trainerInfo))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
            case .failure(let error):
                if let error = error as? BeTrainerAddError, error == .authenticationError {
                    print("Authentication error")
                } else {
                    print("Error loading trainer info: \(error.localizedDescription)")
                }
            }
        }, receiveValue: { [weak self] trainerInfo in
            self?.trainer = trainerInfo
            self?.getInformationForEdit()
        })
        .store(in: &cancellables)
    }
    
    func getInformationForEdit() {
        self.emailEdit = trainer?.email ?? ""
        self.descriptionEdit = trainer?.description ?? ""
        self.locationEdit = trainer?.location ?? ""
        self.gymsEdit = trainer?.gyms ?? ""
        self.phoneNumberEdit = trainer?.phoneNumber ?? ""
        self.priceEdit = trainer?.price ?? ""
        self.instagramEdit = trainer?.instagram ?? ""
        self.facebookEdit = trainer?.facebook ?? ""
        self.linkedinEdit = trainer?.linkedIn ?? ""
        self.webLinkEdit = trainer?.webLink ?? ""
    }
    
    func updateTrainerAllInformation(newPhoneNumber: String, newEmail: String, newDescription: String, newLocation: String, newGyms: String, newWebLink: String, newInstagram: String, newFacebook: String, newLinkedIn: String, newPrice: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.updateTrainerAllInformation(userId: authDataResult.uid, trainerInformationId: trainer!.id, newPhoneNumber: newPhoneNumber, newEmail: newEmail, newDescription: newDescription, newLocation: newLocation, newGyms: newGyms, newWebLink: newWebLink, newInstagram: newInstagram, newFacebook: newFacebook, newLinkedIn: newLinkedIn, newPrice: newPrice)
        }
    }
}


// func loadCurrentTrainer() async throws {
//     do {
//         let authDataResult = try AuthenticationManager.shared.authenticatedUser()
//
//         guard let trainerInfo = try? await // UserManager.shared.getFirstTrainerInformation(userId: authDataResult.uid) else {
//             throw BeTrainerAddError.trainerRetrievalError
//         }
//         self.trainer = trainerInfo
//
//         try? await getInformationForEdit()
//
//
//         print(BeTrainerAddError.trainerDataLoaded.localizedDescription)
//     } catch {
//         // An authentication issue
//         throw BeTrainerAddError.authenticationError
//     }
// }
