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
    
    // username?
    @Published var fullname: String = ""
    @Published var description: String = ""
    @Published var gyms: [String] = []
    @Published var phoneNumber: String = ""
    @Published var webLink: String = ""
    @Published var instagram: String = ""
    @Published var facebook: String = ""
    @Published var none: String = "" // !
    
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
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FillInformationViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 15){
                VStack(spacing: 10) { // your name, about you and etc
                    HStack {
                        Text("Fullname:")
                            .font(.system(size: 19))
                        TextField("Name and last name", text: $viewModel.fullname)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Number:")
                            .font(.system(size: 19))
                        TextField("Phone number", text: $viewModel.phoneNumber)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Gyms:")
                            .font(.system(size: 19))
                        TextField("Gyms", text: $viewModel.none)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Link:")
                            .font(.system(size: 19))
                        TextField("Web link", text: $viewModel.webLink)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Instagram:")
                            .font(.system(size: 19))
                        TextField("Instagram", text: $viewModel.instagram)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("Facebook:")
                            .font(.system(size: 19))
                        TextField("Facebook", text: $viewModel.facebook)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                    
                    HStack {
                        Text("About you:")
                            .font(.system(size: 19))
                            .padding(.bottom, 75)
                        TextEditor(text: $viewModel.description)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 100)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                        Spacer()
                    }
                }
                
                Button(action: {
                    viewModel.addTrainerFullname(fullname: viewModel.fullname)
                    dismiss()
                }) {
                    Text("Add information")
                        .frame(width: 130, height: 20)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct FillInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FillInformationView()
    }
}
