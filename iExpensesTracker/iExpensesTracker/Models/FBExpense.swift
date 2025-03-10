//
//  Untitled.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import Foundation

struct FBExpense: Identifiable, Codable {
    let id: String
    let name: String
    let category: String
    let amount: Double
    let date: Date
    
    init(
        id: String = UUID().uuidString,
        name: String,
        category: String,
        amount: Double,
        date: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.date = date
    }
}
