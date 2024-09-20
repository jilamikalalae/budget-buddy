//
//  StringExtension.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import Foundation
import UIKit

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
    
}


