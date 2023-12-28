//
//  View+EmailSections.swift
//  GymUp
//
//  Created by Denis Sinitsa on 02.09.2023.
//

import SwiftUI

extension SettingsView {
    var emailSections: some View {
        VStack {
            Section {
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
            } header: {
                Text("Email functions")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)

    }
}
