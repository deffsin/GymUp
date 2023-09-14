//
//  TrainerInformationModel.swift
//  GymUp
//
//  Created by Denis Sinitsa on 14.09.2023.
//

import Foundation

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
