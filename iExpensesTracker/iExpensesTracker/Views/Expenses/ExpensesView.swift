
//
//  Untitled.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

struct ExpensesView: View {
    var body: some View {
        ZStack {
            Color.iETLightBackground.ignoresSafeArea()
            Text("Expenses")
                .font(.title)
                .foregroundColor(.iETPrimaryGreen)
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
