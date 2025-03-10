//
//  ExpensesViewModel.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import SwiftData

final class ExpensesViewModel: ObservableObject {
    private var repository: ExpensesRepository?
        
    @Published var expenses: [DomainExpense] = []
    @Published var newExpenseAmount = ""
    @Published var selectedCategory = "Food"
    @Published var newExpenseName = ""
    
    @AppStorage("storagePreference") private var storagePreference = StorageOption.cloud.rawValue
    
    private let dataManager = DataManager.shared
    
    func loadExpenses(context: ModelContext) {
        let repository = dataManager.getRepository(storageOption: currentStorageOption, context: context)
        repository.fetchExpenses { [weak self] expenses, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Fetch error: \(error.localizedDescription)")
                } else {
                    self?.expenses = expenses
                }
            }
        }
    }
    
    func addExpense(context: ModelContext) {
        guard let amountValue = Double(newExpenseAmount) else { return }
        let expense = DomainExpense(name: newExpenseName, category: selectedCategory, amount: amountValue)
        
        let repository = dataManager.getRepository(storageOption: currentStorageOption, context: context)
        repository.addExpense(expense) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Add error: \(error.localizedDescription)")
                } else {
                    self.loadExpenses(context: context)
                    self.newExpenseAmount = ""
                    self.selectedCategory = "Food"
                    self.newExpenseName = ""
                }
            }
        }
    }
    
    func deleteExpense(_ expense: DomainExpense, context: ModelContext) {
        let repository = dataManager.getRepository(storageOption: currentStorageOption, context: context)
        repository.deleteExpense(expense) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Delete error: \(error.localizedDescription)")
                } else {
                    self.loadExpenses(context: context)
                }
            }
        }
    }
    
    private var currentStorageOption: StorageOption {
        StorageOption(rawValue: storagePreference) ?? .cloud
    }
}
