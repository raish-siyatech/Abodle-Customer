//
//  ShadowView.swift
//  Abodle
//
//  Created by mac on 29/11/17.
//  Copyright © 2017 Siyatech Ventures. All rights reserved.
//

import UIKit

extension UIView {
    
    func installShadow() {
        
        layer.cornerRadius = 2
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 1.0
    }
}
