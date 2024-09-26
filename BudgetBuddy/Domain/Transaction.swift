//
//  transaction.swift
//  BudgetBuddy
//
//  Created by Jilamika on 17/9/2567 BE.
//

import Foundation
//struct TransactionClass: Codable {
//    let transaction: [Transaction]
//
//    enum CodingKeys: String, CodingKey {
//        case transaction = "test"
//    }
//}

struct TransactionDetail{
    let id: String
    let image: String
    let category: String
    let amount: Int
    let categoryIcon: String
    let date: String
    let note: String
    let type: CategoryType
}

struct Transaction{
    let date: String
    let transactions: [TransactionDetail]
}



