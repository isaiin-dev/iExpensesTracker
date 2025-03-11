//
//  MockExpensesRepository.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//
import Foundation
@testable import iExpensesTracker

class MockExpensesRepository: ExpensesRepository {
    var expensesToReturn: [DomainExpense] = []
    
    func addExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        expensesToReturn.append(expense)
        completion(nil)
    }
    
    func fetchExpenses(completion: @escaping ([DomainExpense], Error?) -> Void) {
        completion(expensesToReturn, nil)
    }
    
    func deleteExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        expensesToReturn.removeAll { $0.id == expense.id }
        completion(nil)
    }
}
