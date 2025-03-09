//
//  Item.swift
//  iExpensesTracker
//
//  Created by Alejandro isai Acosta Martinez on 09/03/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
