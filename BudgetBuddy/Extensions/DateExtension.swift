//
//  DateExtension.swift
//  BudgetBuddy
//
//  Created by Jilamika on 22/9/2567 BE.
//

import Foundation

extension Date {
    func ToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        return dateFormatter.string(from: self)
    }
        
}
