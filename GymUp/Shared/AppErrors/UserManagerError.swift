//
//  UserManagerError.swift
//  GymUp
//
//  Created by Denis Sinitsa on 18.09.2023.
//

import Foundation
import SwiftUI

enum UserManagerError: Error, LocalizedError {
    case connectionFailed
    case invalidData
    case unauthorized
    case unknownError

    var errorDescription: String? {
        switch self {
        case .connectionFailed:
            return "Failed to connect to the database"
        case .invalidData:
            return "Received invalid data from the database"
        case .unauthorized:
            return "User is not authorized"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}
