//
//  User.swift
//  Abodle
//
//  Created by mac on 23/11/17.
//  Copyright © 2017 Siyatech Ventures. All rights reserved.
//

import UIKit

class Customer: NSObject {

    public var customerName: String?
    public var email: String?
    public var deviceKey: String?
    public var plateformType: String?
    public var countryCode: String?
    public var contactNumber: String?
    public var customerId: String?
    public var isMobVerified: String?
    public var dicAuth: NSDictionary?
    public var authenticationKey: String?
    public var authenticationValue: String?
    public var customerStatus: String?
    public var imageUrl: String?
    
    required init(dic: NSDictionary) {
        
        customerName = dic["customer_name"] as? String
        email = dic["email_id"] as? String
        deviceKey = dic["device_key"] as? String
        plateformType = dic["platform_type"] as? String
        countryCode = dic["country_code"] as? String
        contactNumber = dic["contact_number"] as? String
        customerId = String(describing: (dic["customer_id"])!)
        isMobVerified = dic["isMobVerified"] as? String
        dicAuth = dic["authentication"] as? NSDictionary
        customerStatus = dic["customer_status"] as? String
        imageUrl = dic["image_url"] as? String
        
        if let dicA:NSDictionary = dicAuth {
            
            authenticationKey = dicA["key"] as? String
            authenticationValue = dicA["value"] as? String

        }
    }
}
