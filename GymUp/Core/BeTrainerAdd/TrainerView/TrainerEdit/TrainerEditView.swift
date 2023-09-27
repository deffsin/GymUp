//
//  TrainerEditView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 26.09.2023.
//

import SwiftUI

struct TrainerEditView: View {
    @ObservedObject var viewModel: TrainerEditViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                VStack {
                    InformationField(title: "Fullname:", placeholder: "Name and last name", text: $viewModel.fullnameEdit, isValid: viewModel.fullnameIsValid)
                    InformationField(title: "Email:", placeholder: "Email", text: $viewModel.emailEdit, isValid: viewModel.emailIsValid, keyboardType: .emailAddress)
                    InformationField(title: "Number:", placeholder: "Phone number", text: $viewModel.phoneNumberEdit, isValid: viewModel.phoneNumberIsValid, keyboardType: .phonePad)
                    InformationField(title: "Location", placeholder: "Location", text: $viewModel.locationEdit, isValid: viewModel.locationIsValid)
                    InformationField(title: "Gyms:", placeholder: "Gyms", text: $viewModel.gymsEdit, isValid: viewModel.gymsIsValid)
                }
                VStack {
                    InformationFieldWithoutMarks(title: "Link:", placeholder: "Web link", text: $viewModel.webLinkEdit)
                    InformationFieldWithoutMarks(title: "Instagram:", placeholder: "Instagram", text: $viewModel.instagramEdit)
                    InformationFieldWithoutMarks(title: "Facebook:", placeholder: "Facebook", text: $viewModel.facebookEdit)
                    InformationFieldWithoutMarks(title: "LinkedIn", placeholder: "LinkedIn", text: $viewModel.linkedinEdit)
                    InformationField(title: "Hourly rate:", placeholder: "Hourly rate", text: $viewModel.priceEdit, isValid: viewModel.priceIsValid)
                }
                
                VStack {
                    HStack {
                        Text("About you:")
                            .font(.system(size: 19))
                            .padding(.bottom, 75)
                        TextEditor(text: $viewModel.descriptionEdit)
                            .padding([.horizontal, .vertical], 5)
                            .frame(width: 250, height: 100)
                            .overlay (
                                ZStack {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.red)
                                        .opacity(
                                            viewModel.descriptionEdit.count < 1 ? 0.0 :
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
            }
            .padding(.horizontal, 10)
        }
        .task {
            viewModel.loadCurrentTrainer()
        }
    }
}

struct TrainerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerEditView(viewModel: TrainerEditViewModel())
    }
}
