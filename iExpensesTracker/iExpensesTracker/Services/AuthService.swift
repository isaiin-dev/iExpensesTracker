//
//  AuthService.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 09/03/25.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

/// Handles user authentication with Google and Apple.
final class AuthService {
    
    static let shared = AuthService()
    
    private init() { }
    
    /// Signs in with Google.
    /// - Parameter completion: Returns a Firebase `AuthDataResult` or an `Error`.
    func signInWithGoogle(presentingVC: UIViewController, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthError.invalidClientID))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let idToken = result?.user.idToken?.tokenString,
                  let accessToken = result?.user.accessToken.tokenString else {
                completion(.failure(AuthError.missingToken))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    completion(.success(authResult))
                } else {
                    completion(.failure(AuthError.unknown))
                }
            }
        }
    }
}

enum AuthError: Error {
    case invalidClientID
    case missingToken
    case unknown
}
