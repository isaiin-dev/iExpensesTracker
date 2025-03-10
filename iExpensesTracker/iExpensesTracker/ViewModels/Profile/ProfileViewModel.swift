//
//  ProfileViewModel.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import FirebaseAuth

enum StorageOption: String {
    case local, cloud
}

final class ProfileViewModel: ObservableObject {
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var photoURL: URL? = nil
    
    @AppStorage("storagePreference") var storagePreference: String = StorageOption.cloud.rawValue {
        didSet {
            
        }
    }
    
    init() {
        fetchUserData()
    }
    
    /// Returns the storage preference as an enum.
    var currentStorageOption: StorageOption {
        StorageOption(rawValue: storagePreference) ?? .cloud
    }
    
    /// Assigns a new preference (converted to String by AppStorage).
    func setStorageOption(_ option: StorageOption) {
        storagePreference = option.rawValue
    }
    
    /// Get authenticated user data
    private func fetchUserData() {
        if let user = Auth.auth().currentUser {
            displayName = user.displayName ?? "No Name"
            email = user.email ?? "No Email"
            if let url = user.photoURL {
                photoURL = url
            }
        }
    }
}
