//
//  DomainExpense.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import Foundation

struct DomainExpense: Identifiable, Codable {
    var id: String
    var name: String
    var category: String
    var amount: Double
    var date: Date
    
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
