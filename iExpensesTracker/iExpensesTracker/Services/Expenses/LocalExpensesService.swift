//
//  LocalExpensesService.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftData
import Foundation

final class LocalExpensesService: ExpensesRepository {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func addExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        let local = LocalExpense(
            id: expense.id,
            name: expense.name,
            category: expense.category,
            amount: expense.amount,
            date: expense.date
        )
        context.insert(local)
        do {
            try context.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func fetchExpenses(completion: @escaping ([DomainExpense], Error?) -> Void) {
        do {
            let locals = try context.fetch(FetchDescriptor<LocalExpense>())
            let domain = locals.map {
                DomainExpense(
                    id: $0.id,
                    name: $0.name,
                    category: $0.category,
                    amount: $0.amount,
                    date: $0.date
                )
            }
            completion(domain, nil)
        } catch {
            completion([], error)
        }
    }
    
    func deleteExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        let fetch = FetchDescriptor<LocalExpense>(predicate: #Predicate { $0.id == expense.id })
        do {
            if let found = try context.fetch(fetch).first {
                context.delete(found)
                try context.save()
                completion(nil)
            } else {
                completion(nil)
            }
        } catch {
            completion(error)
        }
    }
}
