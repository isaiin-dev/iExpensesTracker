//
//  ProfileView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.iETLightBackground.ignoresSafeArea()
            Text("Profile")
                .font(.title)
                .foregroundColor(.iETPrimaryGreen)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
