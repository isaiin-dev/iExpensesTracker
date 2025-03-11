//
//  HomeViewModel.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import SwiftData

final class HomeViewModel: ObservableObject {
    @Published var expenses: [DomainExpense] = []
    @Published var expensesByMonth: [String: [DomainExpense]] = [:]
    @Published var expensesByCategory: [String: Double] = [:]
    
    private let dataManager = DataManager.shared
    
    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    func loadData(context: ModelContext) {
        let repository = dataManager.getRepository(storageOption: currentStorageOption, context: context)
        repository.fetchExpenses { [weak self] expenses, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Fetch error: \(error.localizedDescription)")
                } else {
                    self?.expenses = expenses
                    self?.aggregateData()
                }
            }
        }
    }
    
    private func aggregateData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        expensesByMonth = Dictionary(grouping: expenses, by: { formatter.string(from: $0.date) })
        
        var categorySums: [String: Double] = [:]
        for expense in expenses {
            categorySums[expense.category, default: 0] += expense.amount
        }
        expensesByCategory = categorySums
    }
    
    private var currentStorageOption: StorageOption {
        StorageOption(rawValue: UserDefaults.standard.string(forKey: "storagePreference") ?? StorageOption.cloud.rawValue) ?? .cloud
    }
}
