//
//  ExpensesRepository.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import Foundation

protocol ExpensesRepository {
    func addExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void)
    func fetchExpenses(completion: @escaping ([DomainExpense], Error?) -> Void)
    func deleteExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void)
}

