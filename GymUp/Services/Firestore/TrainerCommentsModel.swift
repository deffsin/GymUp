//
//  TrainerComments.swift
//  GymUp
//
//  Created by Denis Sinitsa on 29.09.2023.
//

import Foundation

struct TrainerComments: Codable {
    let id: String
    let fullname: String?
    let description: String?
    let dataCreated: Date?
    
    
    init(auth: AuthDataResultModel) {
        self.id = auth.uid
        self.fullname = nil
        self.description = nil
        self.dataCreated = Date()
    }
    
    init(
    id: String,
    fullname: String? = nil,
    description: String? = nil,
    dataCreated: Date? = nil
    ) {
        self.id = id
        self.fullname = fullname
        self.description = description
        self.dataCreated = dataCreated

    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullname = "fullname"
        case description = "description"
        case dataCreated = "data_created"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.fullname = try container.decodeIfPresent(String.self, forKey: .fullname)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.dataCreated = try container.decodeIfPresent(Date.self, forKey: .dataCreated)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encodeIfPresent(self.fullname, forKey: .fullname)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.dataCreated, forKey: .dataCreated)

    }
}
