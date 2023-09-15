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
                LinearGradient(colors: [.black.opacity(0.9), .mint.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        UserInfoView()
                        DetailsView()
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
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
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct UserInfoView: View {
    @StateObject var viewModel = TrainerViewModel()
    
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
                    socialButton(urlString: "https://linkedin.com/in/deffsin", imageName: "linkedin") // i don't have linkedin
                    socialButton(urlString: "\(trainer.webLink)", imageName: "web")
                        .padding(.trailing, 3)
                }
                .padding(8)
                .foregroundColor(Color.white)
                .background(Color.pink)
                .cornerRadius(15)
            }
        }
        .task {
            try? await viewModel.loadCurrentUser()
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

struct DetailsView: View {
    var body: some View {
        VStack {
            HStack {
                RatingsView()
                Divider()
                RatingsInfo()
            }
            .frame(width: 300, height: 50)
            Divider()
            
            AboutMeView()
            Divider()
            ResourcesView()
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding(.bottom, 10)
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(15)
    }
}

struct RatingsView: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Text("Comments: ")
                    .font(.system(size: 17))
                Text("0")
                    .bold()
            }
            .padding()
        }
    }
}

struct RatingsInfo: View {
    var body: some View {
        HStack(spacing: 2) {
            Text("Rating: ")
                .font(.system(size: 17))
            Text("4.7")
                .bold()
            Image(systemName: "star.fill")
                .foregroundColor(Color.yellow)
        }
        .padding()
    }
}

struct AboutMeView: View {
    @StateObject var viewModel = TrainerViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let trainer = viewModel.trainer {
                Text("About me:")
                    .bold()
                Text(trainer.description ?? "")
                Spacer()
            }
        }
        .padding(.horizontal, 10)
        .task {
            try? await viewModel.loadCurrentUser()
        }
    }
}

struct ResourcesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Fitness resources:")
                .bold()
            ResourceButton(title: "Trainer programs")
            Divider()
            ResourceButton(title: "Nutrition for muscle gain")
            Divider()
            ResourceButton(title: "Nutrition for weight loss")
        }
        .padding(.horizontal, 10)
    }
    
    func ResourceButton(title: String) -> some View {
        HStack {
            Button(action: {}) {
                Text(title)
                    .foregroundColor(Color.blue)
            }
            Spacer()
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
