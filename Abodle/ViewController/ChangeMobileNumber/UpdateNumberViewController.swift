//
//  UpdateNumberViewController.swift
//  Abodle
//
//  Created by mac on 24/11/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class UpdateNumberViewController: UIViewController {

    @IBOutlet weak var txtFieldNumber: DTTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBackClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnChangeNumberClicked(_ sender: Any) {
        
        if txtFieldNumber.text?.characters.count == 0 {
            
            txtFieldNumber.showError(message: "Please enter mobile number")
            return
        }
        
        let data = CoreDataManager.fetch_data_from_CoreData()
        let d = data[0]
        
        let para = ["customer_id":d.customer_id!,"contact_number":"0" + "\(self.txtFieldNumber.text!)"] as [String : Any]
        updatedMobileNumber(dic: para as NSDictionary)
        
    }
}

//MARK:HelperMethod

extension UpdateNumberViewController {
    
    
    func updatedMobileNumber(dic: NSDictionary) {
        
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.UPDATEMOBILENO as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
                 self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
