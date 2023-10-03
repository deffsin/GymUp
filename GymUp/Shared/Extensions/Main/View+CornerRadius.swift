//
//  View+CornerRadius.swift
//  GymUp
//
//  Created by Denis Sinitsa on 03.10.2023.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
