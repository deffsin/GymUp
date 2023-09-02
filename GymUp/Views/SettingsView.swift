//
//  SettingsView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            
            Button(action: {
                Task {
                    do {
                        // try await viewModel.updateEmail(email: String)
                        print("Email update!")
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Update email")
                    .bold()
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
            }
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password reset!")
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Reset password")
                    .bold()
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
            }
            
            Button(action: {
                Task {
                    do {
                        // try await viewModel.updatePassword(password: )
                        print("Update password!")
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Update password")
                    .bold()
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(10)
            }
            
            Button(action: {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }) {
                Text("Log out")
                    .bold()
                    .font(.system(size: 13))
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
