//
//  UserInfoView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 16.09.2023.
//

import SwiftUI

struct UserInfoView: View {
    @ObservedObject var viewModel: BeTrainerAddViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Image("me")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(color: .white, radius: 2)
            
            if let trainer = viewModel.trainer {
                if let trainerName = viewModel.user {
                    VStack(spacing: 5){
                        HStack(spacing: 5) {
                            Image(systemName: "person.text.rectangle")
                                .font(.system(size: 12))
                            
                            Text(trainerName.username ?? "")
                                .bold()
                                .font(.system(size: 19))
                        }
                        
                        HStack(spacing: 5) {
                            Image(systemName: "location")
                                .font(.system(size: 12))
                            
                            Text(trainer.location ?? "")
                                .font(.system(size: 15))
                        }
                        .foregroundColor(Color.white.opacity(0.9))
                        
                        HStack(spacing: 5) {
                            Image(systemName: "dumbbell")
                                .font(.system(size: 12))
                            
                            Text("Trainer at: \(trainer.gyms ?? "")")
                                .font(.system(size: 17))
                        }
                    }
                    
                    HStack(spacing:25) {
                        socialButton(urlString: "\(trainer.instagram ?? "")", imageName: "instagram")
                        socialButton(urlString: "\(trainer.facebook ?? "")", imageName: "facebook")
                        socialButton(urlString: "\(trainer.linkedIn ?? "")", imageName: "linkedin")
                        socialButton(urlString: "\(trainer.webLink ?? "")", imageName: "web")
                            .padding(.trailing, 3)
                    }
                    .padding(8)
                    .foregroundColor(Color.white)
                    .background(Color.pink)
                    .cornerRadius(15)
                    .shadow(color: .pink, radius: 5)
                }
            }
        }
    }
    
    func socialButton(urlString: String, imageName: String) -> some View {
        Button(action: {
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }) {
            Image(imageName)
                .resizable()
                .frame(width: 35, height: 35)
        }
    }
}
