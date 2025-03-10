//
//  MainTabView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Home
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }

            // Expenses
            ExpensesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Expenses")
                }

            // Profile
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
        }
        .tint(.iETPrimaryGreen)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
