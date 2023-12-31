//
//  TrainerInformationModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import Foundation

struct TrainerInformation: Codable {
    
    let id: String
    let userDocId: String?
    let fullname: String?
    let description: String?
    let location: String?
    let gyms: String?
    let email: String?
    let phoneNumber: String?
    let instagram: String?
    let facebook: String?
    let webLink: String?
    let linkedIn: String?
    let rating: Int? // Double!
    let reviews: Int? // Int!
    let price: String? // String!
    
    init(auth: AuthDataResultModel) {
        self.id = auth.uid
        self.userDocId = nil
        self.fullname = nil
        self.description = nil
        self.location = nil
        self.gyms = nil
        self.email = nil
        self.phoneNumber = nil
        self.instagram = nil
        self.facebook = nil
        self.webLink = nil
        self.linkedIn = nil
        self.rating = nil
        self.reviews = nil
        self.price = nil
    }
    
    init(
    id: String,
    userDocId: String? = nil,
    fullname: String? = nil,
    description: String? = nil,
    location: String? = nil,
    gyms: String? = nil,
    email: String? = nil,
    phoneNumber: String? = nil,
    instagram: String? = nil,
    facebook: String? = nil,
    webLink: String? = nil,
    linkedIn: String? = nil,
    rating: Int? = nil,
    reviews: Int? = nil,
    price: String? = nil
    
    ) {
        self.id = id
        self.userDocId = userDocId
        self.fullname = fullname
        self.description = description
        self.location = location
        self.gyms = gyms
        self.email = email
        self.phoneNumber = phoneNumber
        self.instagram = instagram
        self.facebook = facebook
        self.webLink = webLink
        self.linkedIn = linkedIn
        self.rating = rating
        self.reviews = reviews
        self.price = price
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userDocId = "user_doc_id"
        case fullname = "fullname"
        case description = "description"
        case location = "location"
        case gyms = "gyms"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case instagram = "instagram"
        case facebook = "facebook"
        case webLink = "web_link" // ???
        case linkedIn = "linkedIn"
        case rating = "rating"
        case reviews = "reviews"
        case price = "price"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.userDocId = try container.decode(String.self, forKey: .userDocId)
        self.fullname = try container.decode(String.self, forKey: .fullname)
        self.description = try container.decode(String.self, forKey: .description)
        self.location = try container.decode(String.self, forKey: .location)
        self.gyms = try container.decode(String.self, forKey: .gyms)
        self.email = try container.decode(String.self, forKey: .email)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.instagram = try container.decode(String.self, forKey: .instagram)
        self.facebook = try container.decode(String.self, forKey: .facebook)
        self.webLink = try container.decode(String.self, forKey: .webLink)
        self.linkedIn = try container.decode(String.self, forKey: .linkedIn)
        self.rating = try container.decode(Int.self, forKey: .rating)
        self.reviews = try container.decode(Int.self, forKey: .reviews)
        self.price = try container.decode(String.self, forKey: .price)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.userDocId, forKey: .userDocId)
        try container.encode(self.fullname, forKey: .fullname)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.location, forKey: .location)
        try container.encode(self.gyms, forKey: .gyms)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
        try container.encode(self.instagram, forKey: .instagram)
        try container.encode(self.facebook, forKey: .facebook)
        try container.encode(self.webLink, forKey: .webLink)
        try container.encode(self.linkedIn, forKey: .linkedIn)
        try container.encode(self.rating, forKey: .rating)
        try container.encode(self.reviews, forKey: .reviews)
        try container.encode(self.price, forKey: .price)
    }
}
