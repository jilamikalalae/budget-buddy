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
}
