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

struct TransactionDetail: Codable {
    let image: String
    let category: String
    let amount: Int
    let categoryIcon: String
}

struct Transaction: Codable {
    let date: String
    let transactions: [TransactionDetail]
}



