//
//  HomeView.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.iETLightBackground.ignoresSafeArea()
            Text("Home")
                .font(.title)
                .foregroundColor(.iETPrimaryGreen)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
