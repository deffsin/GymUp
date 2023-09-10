//
//  FillInformationView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 10.09.2023.
//

import SwiftUI

@MainActor
final class FillInformationViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    @Published var fullname: String = ""
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.authenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    func addTrainerFullname(fullname: String) {
        Task {
            let authDataResult = try AuthenticationManager.shared.authenticatedUser()
            try? await UserManager.shared.addTrainerFullname(userId: authDataResult.uid, fullname: fullname)
        }
    }
    
}

struct FillInformationView: View {
    
    @StateObject var viewModel = FillInformationViewModel()
    
    @State var description: String = ""
    @State var gyms: [String] = []
    @State var phoneNumber: String = ""
    @State var webLink: String = ""
    @State var instagram: String = ""
    @State var facebook: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 15){
                VStack(spacing: 10) { // your name, about you and etc
                    TextField("Name and last name", text: $viewModel.fullname)
                        .padding([.horizontal, .vertical], 5)
                        .frame(width: 250, height: 40)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        }
                    
                    TextEditor(text: $description)
                        .padding([.horizontal, .vertical], 5)
                        .frame(width: 250, height: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        }
                }
                
                Button(action: {
                    viewModel.addTrainerFullname(fullname: viewModel.fullname)
                }) {
                    Text("Add information")
                        .frame(width: 130, height: 20)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
        }
    }
}

struct FillInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FillInformationView()
    }
}
