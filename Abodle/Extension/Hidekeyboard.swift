//
//  Hidekeyboard.swift
//  Abodle
//
//  Created by mac on 23/11/17.
//  Copyright © 2017 Siyatech Ventures. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: Hide keyboard to click outside
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
}
