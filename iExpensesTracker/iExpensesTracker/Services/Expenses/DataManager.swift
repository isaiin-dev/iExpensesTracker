//
//  DataManager.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 10/03/25.
//

import SwiftUI
import SwiftData

final class DataManager {
    static let shared = DataManager()
    
    private let firebaseService = FirebaseExpensesService()
    
    func getRepository(storageOption: StorageOption, context: ModelContext) -> ExpensesRepository {
        switch storageOption {
        case .local:
            return LocalExpensesService(context: context)
        case .cloud:
            return firebaseService
        }
    }
}
