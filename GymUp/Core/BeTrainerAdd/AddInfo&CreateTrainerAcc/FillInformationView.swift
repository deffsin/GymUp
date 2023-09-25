//
//  FillInformationView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 10.09.2023.
//

import SwiftUI

struct FillInformationView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FillInformationViewModel()

    var body: some View {
        ZStack {
            
            if viewModel.isAddingInformation {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                    .scaleEffect(2)
            } else {
                VStack(spacing: 15) {
                    VStack {
                        InformationField(title: "Fullname:", placeholder: "Name and last name", text: $viewModel.fullname, isValid: viewModel.fullnameIsValid)
                        InformationField(title: "Email:", placeholder: "Email", text: $viewModel.email, isValid: viewModel.emailIsValid, keyboardType: .emailAddress)
                        InformationField(title: "Number:", placeholder: "Phone number", text: $viewModel.phoneNumber, isValid: viewModel.phoneNumberIsValid, keyboardType: .phonePad)
                        InformationField(title: "Location", placeholder: "Location", text: $viewModel.location, isValid: viewModel.locationIsValid)
                        InformationField(title: "Gyms:", placeholder: "Gyms", text: $viewModel.gyms, isValid: viewModel.gymsIsValid)
                    }
                    VStack {
                        InformationField(title: "Link:", placeholder: "Web link", text: $viewModel.webLink)
                        InformationField(title: "Instagram:", placeholder: "Instagram", text: $viewModel.instagram)
                        InformationField(title: "Facebook:", placeholder: "Facebook", text: $viewModel.facebook)
                        InformationField(title: "LinkedIn", placeholder: "LinkedIn", text: $viewModel.linkedIn)
                        InformationField(title: "Hourly rate:", placeholder: "Hourly rate", text: $viewModel.price, isValid: viewModel.priceIsValid)
                    }
                    
                    VStack {
                        HStack {
                            Text("About you:")
                                .font(.system(size: 19))
                                .padding(.bottom, 75)
                            TextEditor(text: $viewModel.description)
                                .padding([.horizontal, .vertical], 5)
                                .frame(width: 250, height: 100)
                                .overlay (
                                    ZStack {
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color.red)
                                            .opacity(
                                                viewModel.description.count < 1 ? 0.0 :
                                                    (viewModel.descriptionIsValid) ? 0.0 : 1.0
                                            )
                                        
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color.green)
                                            .opacity(
                                                (viewModel.descriptionIsValid) ? 1.0 : 0.0
                                            )
                                    }
                                    .padding([.bottom, .trailing], 5)
                                    ,alignment: .bottomTrailing
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                }
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                        viewModel.addTrainerAllInformation(fullname: viewModel.fullname, phoneNumber: viewModel.phoneNumber, email: viewModel.email, description: viewModel.description, location: viewModel.location, gyms: viewModel.gyms, webLink: viewModel.webLink, instagram: viewModel.instagram, facebook: viewModel.facebook, linkedIn: viewModel.linkedIn, rating: viewModel.rating, comments: viewModel.comments, price: viewModel.price)
                        viewModel.toggleTrainerStatus()
                        dismiss()
                    }) {
                        Text("Add information")
                            .frame(width: 130, height: 20)
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(15)
                            .opacity(viewModel.showButton ? 1.0 : 0.5)
                    }
                    .disabled(!viewModel.showButton)
                }
                .padding(.horizontal, 10)
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct InformationField: View {
    
    var title: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 19))
            TextField(placeholder, text: $text)
                .padding([.horizontal, .vertical], 5)
                .frame(width: 250, height: 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
                .overlay (
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.red)
                            .opacity(
                                text.count < 1 ? 0.0 :
                                    (isValid ?? false) ? 0.0 : 1.0
                            )
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .opacity(
                                (isValid ?? false) ? 1.0 : 0.0
                            )
                    }
                    .padding(.trailing, 3)
                    ,alignment: .trailing
                )
                .keyboardType(keyboardType)
            Spacer()
        }
    }
}
