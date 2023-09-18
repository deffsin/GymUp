//
//  BeTrainerAddError.swift
//  GymUp
//
//  Created by Denis Sinitsa on 18.09.2023.
//

import Foundation
import SwiftUI

enum BeTrainerAddError: Error {
    case authenticationError
    case userRetrievalError
    case trainerRetrievalError
    case updateError
    case userDataLoaded
    case trainerDataLoaded
    
    var localizedDescription: String {
        switch self {
        case .authenticationError:
            return "There was an issue with user authentication"
        case .userRetrievalError:
            return "Could not retrieve the user's data"
        case .trainerRetrievalError:
            return "Could not retrieve the trainer's information"
        case .updateError:
            return "Failed to update the trainer status"
        case .userDataLoaded:
            return "User data is loaded"
        case .trainerDataLoaded:
            return "Trainer data is loaded"
        }
    }
}
