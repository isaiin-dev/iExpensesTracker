//
//  FirebaseExpensesService.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import FirebaseFirestore
import Foundation

final class FirebaseExpensesService: ExpensesRepository {
    
    private let db = Firestore.firestore()
    private let collectionName = "expenses"
    
    func addExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        let fb = FBExpense(
            id: expense.id,
            name: expense.name,
            category: expense.category,
            amount: expense.amount,
            date: expense.date
        )
        do {
            try db.collection(collectionName)
                .document(fb.id)
                .setData(from: fb)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func fetchExpenses(completion: @escaping ([DomainExpense], Error?) -> Void) {
        db.collection(collectionName).getDocuments { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion([], error)
                return
            }
            let fbExpenses: [FBExpense] = snapshot.documents.compactMap { doc in
                try? doc.data(as: FBExpense.self)
            }
        
            let domain = fbExpenses.map {
                DomainExpense(
                    id: $0.id,
                    name: $0.name,
                    category: $0.category,
                    amount: $0.amount,
                    date: $0.date
                )
            }
            completion(domain, nil)
        }
    }
    
    func deleteExpense(_ expense: DomainExpense, completion: @escaping (Error?) -> Void) {
        db.collection(collectionName).document(expense.id).delete { error in
            completion(error)
        }
    }
}
