//
//  TrainerView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 13.09.2023.
//

import SwiftUI

struct TrainerView: View {
    @StateObject var viewModel = TrainerViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                ScrollView {
                    ZStack {
                        VStack {
                            VStack(spacing: 25){
                                Spacer()
                                // if let trainer = viewModel.trainer {
                                // Text(trainer.fullname ?? "")
                                // Text(trainer.description ?? "")
                                // }
                                VStack(spacing: 15){
                                    Image("image_male") // вокруг аватарки цвет какой то
                                        .resizable()
                                        .aspectRatio(contentMode: .fill) // scaledToFit?
                                        .frame(width: 130, height: 130)
                                        .clipShape(Circle())
                                    
                                    VStack(spacing: 5){
                                        Text("Fullname")
                                            .bold()
                                        
                                        Text("Location")
                                            .font(.system(size: 17))
                                        Text("Trainer at: Gym, MyFitness")
                                    }
                                    
                                    HStack(spacing:25){
                                        Button(action: {
                                            if let url = URL(string: "https://instagram.com/deffsin") {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            Image("instagram")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                        }
                                        
                                        Button(action: {
                                            if let url = URL(string: "https://facebook.com/") {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            Image("facebook")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                        }
                                        
                                        Button(action: {
                                            if let url = URL(string: "https://linkedin.com/in/deffsin") {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            Image("linkedin")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                        }
                                        
                                        Button(action: {
                                            if let url = URL(string: "https://google.com/") {
                                                UIApplication.shared.open(url)
                                            }
                                        }) {
                                            Image("web")
                                                .resizable()
                                                .frame(width: 35, height: 35)
                                        }
                                        
                                    }
                                    .frame(width: 240, height: 50)
                                    .padding([.horizontal, .vertical], 5)
                                    .foregroundColor(Color.white)
                                    .background(Color.pink)
                                    .cornerRadius(15)
                                }
                                
                                VStack {
                                    Text("aaa")
                                }
                                .frame(maxWidth: .infinity, minHeight: 350)
                                .background(Color.blue)
                                .cornerRadius(15)
                                
                                VStack {
                                  // nothing
                                }
                                .frame(maxWidth: .infinity, minHeight: 40)
                            }
                            .foregroundColor(Color.white)
                        }
                        .padding([.leading, .trailing], 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .refreshable {
                try? await Task.sleep(nanoseconds: 1_200_000_000)
                try? await viewModel.loadCurrentUser()
            }

            .task {
                try? await viewModel.loadCurrentUser()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("My profile")
                    .font(.system(size: 24))
            }
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
