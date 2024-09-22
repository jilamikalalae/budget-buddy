//
//  PrimaryData.swift
//  BudgetBuddy
//
//  Created by Jilamika on 21/9/2567 BE.
//

import Foundation
import SwiftUI
import WidgetKit

struct PrimaryData {
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.com.jilamika")) var primaryData : Data = Data()
    let balanceData : Balance
    
    func encodeData() {
        guard let data = try? JSONEncoder().encode(balanceData) else {
            return
        }
        primaryData = data
        WidgetCenter.shared.reloadAllTimelines()
    }
}
