//
//  Category.swift
//  BudgetBuddy
//
//  Created by Jilamika on 18/9/2567 BE.
//

import Foundation

struct Category {
    let image: String
    let name: String
    let type: CategoryType
}

enum CategoryType {
    case income
    case expense
    
    var stringValue: String {
            switch self {
            case .income:
                return "income"
            case .expense:
                return "expense"
            }
    }
    
    init?(from string: String) {
        switch string.lowercased() {
        case "income":
            self = .income
        case "expense":
            self = .expense
        default:
            return nil
        }
    }
}
