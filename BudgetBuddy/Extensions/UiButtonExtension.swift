//
//  extension.swift
//  BudgetBuddy
//
//  Created by Jilamika on 5/9/2567 BE.
//

import Foundation
import UIKit
extension UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}


