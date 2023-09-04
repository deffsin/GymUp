//
//  SignInGoogleHelper.swift
//  GymUp
//
//  Created by Denis Sinitsa on 03.09.2023.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResult {
    let idToken: String
    let accessToken: String
    let email: String?
    let name: String?
}

final class SignInWithGoogleHelper {
        
    @MainActor
    func signIn(viewController: UIViewController? = nil) async throws -> GoogleSignInResult {
        guard let topViewController = viewController ?? topViewController() else {
            throw URLError(.notConnectedToInternet)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topViewController)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let email = gidSignInResult.user.profile?.email
        let name = gidSignInResult.user.profile?.name
        return GoogleSignInResult(idToken: idToken, accessToken: accessToken, email: email, name: name)
    }
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
