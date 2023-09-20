//
//  UserProfileCell.swift
//  GymUp
//
//  Created by Denis Sinitsa on 20.09.2023.
//

import SwiftUI

struct UserProfileCell: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Background() // delete
            VStack {
                HStack {
                    VStack(spacing: 10){
                        Spacer()
                        Image("me")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 105)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))
                            .shadow(color: .white, radius: 2)
                        
                        VStack {
                            HStack(spacing: 3) {
                                Image(systemName: "person.text.rectangle")
                                    .opacity(0.6)
                                    .font(.system(size: 10))
                                
                                Text("Denis")
                                    .font(.system(size: 11))
                                    .bold()
                                Spacer()
                            }
                            HStack(spacing: 3) {
                                Image(systemName: "location")
                                    .opacity(0.6)
                                    .font(.system(size: 10))
                                
                                Text("Tallinn, Estonia")
                                    .font(.system(size: 11))
                                Spacer()
                            }
                            
                            HStack(spacing: 3) {
                                Image(systemName: "eurosign")
                                    .opacity(0.6)
                                    .font(.system(size: 10))
                                
                                Text("20")
                                    .font(.system(size: 11))
                                Spacer()
                                Image(systemName: "star.fill")
                                    .opacity(0.6)
                                    .font(.system(size: 10))
                                
                                Text("4.7")
                                    .font(.system(size: 11))
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 110, height: 180)
                    // .background(Color.red)
                    
                    VStack(spacing: 8){
                        HStack(alignment: .firstTextBaseline, spacing: 3) {
                            Image(systemName: "dumbbell")
                                .opacity(0.6)
                                .font(.system(size: 13))
                            
                            Text("Trainer at: Gym!,  Myfitness")
                                .font(.system(size: 14))
                            Spacer()
                        }
                        
                        VStack {
                            HStack(alignment: .firstTextBaseline, spacing: 3) {
                                Image(systemName: "info.bubble")
                                    .opacity(0.6)
                                    .font(.system(size: 13))
                                Text("With 6 years of experience in the gym, I've honed techniques that deliver results. My approach is tailored to your needs, ensuring that every workout is effective and engaging. Let's reach your fitness goals together")
                                    .font(.system(size: 14))
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 170)
                    // .background(Color.red)
                    
                    Spacer()
                }
                .padding([.horizontal, .vertical], 7)
            }
            .frame(maxWidth: .infinity, minHeight: 170)
            .background(Color.white.opacity(0.8))
            .foregroundColor(Color.black)
            .cornerRadius(15)
            .shadow(color: .black, radius: 8)
            .padding(.horizontal, 20) // delete?
        }
    }
}

struct UserProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileCell(viewModel: MainViewModel())
    }
}
