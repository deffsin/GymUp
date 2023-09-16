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
            
            if let trainer = viewModel.trainer {
                VStack(spacing: 5){
                    Text(trainer.fullname ?? "None")
                        .bold()
                    Text("Tallinn, Estonia")
                        .font(.system(size: 17))
                    Text("Trainer at: Gym, MyFitness")
                }
                
                HStack(spacing:25) {
                    socialButton(urlString: "\(trainer.instagram)", imageName: "instagram")
                    socialButton(urlString: "\(trainer.facebook)", imageName: "facebook")
                    socialButton(urlString: "https://linkedin.com/in/deffsin", imageName: "linkedin")
                    socialButton(urlString: "\(trainer.webLink)", imageName: "web")
                        .padding(.trailing, 3)
                }
                .padding(8)
                .foregroundColor(Color.white)
                .background(Color.pink)
                .cornerRadius(15)
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
