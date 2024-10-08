//
//  TransactionData.swift
//  BudgetBuddy
//
//  Created by Jilamika on 22/9/2567 BE.
//

import Foundation

struct TransactionData {
    let id: String
    let amount: Float
    let category: String
    let categoryIcon: String
    let type: CategoryType
    let note: String
    let date: String
    let imgUrl: String

    // Custom initializer
    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let amount = dict["amount"] as? NSNumber,
              let category = dict["category"] as? String,
              let categoryIcon = dict["categoryIcon"] as? String,
              let type = dict["type"] as? String,
              let note = dict["note"] as? String,
              let date = dict["date"] as? String,
              let imgUrl = dict["imgUrl"] as? String else {
            return nil
        }
        
        self.id = id
        self.amount = Float(truncating: amount)
        self.category = category
        self.categoryIcon = categoryIcon
        self.type = CategoryType(from: type) ?? .income
        self.note = note
        self.date = date
        self.imgUrl = imgUrl
    }
}

