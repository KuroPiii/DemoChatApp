//
//  AuthManagers.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import CryptoKit
import AuthenticationServices

enum GoogleSignInError: Error {
    case unableToGrabTopMostWindow
    case signInPresentationError
    case authSignInError
}
enum AppleSignInError: Error {
    case unableToGrabTopMostWindow
    case authSignInError
}
class AuthManagers: NSObject {
    
    static let shared = AuthManagers()
    let auth = Auth.auth()
    func getCurrentUser() -> User? {
        guard let authUser = auth.currentUser else {
            return nil
        }
        
        return User(userID: authUser.uid, userName: authUser.displayName ?? "Unknown", email: authUser.email, photoURL: authUser.photoURL?.absoluteString, createAt: Date())
    }


    @available(iOS 13, *)
    func signInWithApple(completion: @escaping (Result<User, AppleSignInError>) -> Void) {
//        // Start the sign in flow!
//        guard let window = NSApp.windows.first else {
//            completion(.failure(.unableToGrabTopMostWindow))
//            return
//        }
//        
//        let nonce = randomNonceString()
//        currentNonce = nonce
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = window
//        authorizationController.performRequests()
    }
    func signInWithGoogle(completion: @escaping (Result<User, GoogleSignInError>) -> Void) {
        let clientID = "366221021470-vkfc8sdgoit9jsfserha6n1busc5vret.apps.googleusercontent.com"
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        guard let window = NSApp.windows.first else {
            completion(.failure(.unableToGrabTopMostWindow))
            return
        }
        GIDSignIn.sharedInstance.signIn(withPresenting: window) { [unowned self] result, error in
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString,
                  error == nil
            else {
                completion(.failure(.signInPresentationError))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            auth.signIn(with: credential) { result , error in
                guard let result = result, error == nil else {
                    completion(.failure(.authSignInError))
                    return
                }
                let user = User(userID: result.user.uid, userName: result.user.displayName ?? "Unknown", email: result.user.email, photoURL: result.user.photoURL?.absoluteString, createAt: Date())
                completion(.success((user)))
            }
            // ...
        }
    }
    func signOut() throws {
        try auth.signOut()
    }
}
//extension AuthManagers: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
////        <#code#>
//    }
//    
//    private func randomNonceString(length: Int = 32) -> String {
//      precondition(length > 0)
//      var randomBytes = [UInt8](repeating: 0, count: length)
//      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
//      if errorCode != errSecSuccess {
//        fatalError(
//          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
//        )
//      }
//
//      let charset: [Character] =
//        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//
//      let nonce = randomBytes.map { byte in
//        // Pick a random character from the set, wrapping around if needed.
//        charset[Int(byte) % charset.count]
//      }
//
//      return String(nonce)
//    }
//    @available(iOS 13, *)
//    private func sha256(_ input: String) -> String {
//      let inputData = Data(input.utf8)
//      let hashedData = SHA256.hash(data: inputData)
//      let hashString = hashedData.compactMap {
//        String(format: "%02x", $0)
//      }.joined()
//
//      return hashString
//    }
//    // Unhashed nonce.
////    fileprivate var currentNonce: String?
//    
//}
