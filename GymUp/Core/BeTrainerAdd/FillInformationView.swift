//
//  FillInformationView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 10.09.2023.
//

import SwiftUI

struct FillInformationView: View {
    @State var name: String = ""
    @State var description: String = ""
    @State var gyms: [String] = []
    @State var phoneNumber: String = ""
    @State var instagram: String = ""
    @State var facebook: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Name and last name", text: $name)
                    .padding()
                    .frame(width: 190, height: 50)
                    .
            }
        }
    }
}

struct FillInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FillInformationView()
    }
}
