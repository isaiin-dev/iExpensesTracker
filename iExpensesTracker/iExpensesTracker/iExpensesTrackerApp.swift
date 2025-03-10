//
//  iExpensesTrackerApp.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 09/03/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct iExpensesTrackerApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isUserLoggedIn {
                MainTabView()
                    .preferredColorScheme(.light)
            } else {
                LoginView()
                    .preferredColorScheme(.light)
            }
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        FirebaseApp.configure()
    }
}
