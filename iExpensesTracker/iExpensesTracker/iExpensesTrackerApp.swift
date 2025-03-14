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
            LocalExpense.self,
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
                    .environmentObject(authViewModel)
            } else {
                LoginView()
                    .preferredColorScheme(.light)
                    .environmentObject(authViewModel)
            }
        }
        .modelContainer(sharedModelContainer)
    }
    
    init() {
        FirebaseApp.configure()
    }
}
