//
//  ExpenseHelpers.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI

func iconName(for category: String) -> String {
    switch category {
    case "Food":
        return "fork.knife"
    case "Entertainment":
        return "gamecontroller.fill"
    case "Streaming Services":
        return "tv.fill"
    case "Stationery":
        return "pencil.and.outline"
    case "Home Loan":
        return "house.fill"
    case "Personal Loan":
        return "person.fill.badge.plus"
    case "Holiday":
        return "airplane"
    default:
        return "bag.fill"
    }
}
