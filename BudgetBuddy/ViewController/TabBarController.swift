//
//  TabBarController.swift
//  BudgetBuddy
//
//  Created by Jilamika on 22/9/2567 BE.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    @IBOutlet var bbTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for item in self.bbTabBar.items! {
            item.title = item.title?.localized()
        }

    }
    

}
