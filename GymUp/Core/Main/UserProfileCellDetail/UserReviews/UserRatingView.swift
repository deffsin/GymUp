//
//  UserRatingView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.10.2023.
//

import SwiftUI

struct UserRatingView: View {
    @State var userRating: Int = 0
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > userRating ? offColor : onColor)
                    .onTapGesture {
                        userRating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > userRating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }

}

struct UserRatingView_Previews: PreviewProvider {
    static var previews: some View {
        UserRatingView()
    }
}
