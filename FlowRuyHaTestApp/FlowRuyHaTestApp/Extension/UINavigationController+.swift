//
//  UINavigationController+.swift
//  FlowRuyHaTestApp
//
//  Created by Ruyha on 2023/01/17.
//

import UIKit

extension UINavigationController {
    
    func setExpansionBackbuttonArea() {
        let backButton: UIBarButtonItem = UIBarButtonItem()
        backButton.title = "                             "
        backButton.tintColor = UIColor(named: "textColor")
        self.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
