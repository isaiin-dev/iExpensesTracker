//
//  AuthViewModel.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenToAuthChanges()
    }
    
    deinit {
        removeListener()
    }
    
    /// Observes Firebase Auth state and updates the published property.
    private func listenToAuthChanges() {
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.isUserLoggedIn = (user != nil)
        }
    }
    
    /// Removes the auth state listener when the view model is deallocated.
    private func removeListener() {
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    /// Optional sign-out method if needed.
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign out error: \(error.localizedDescription)")
        }
    }
}
