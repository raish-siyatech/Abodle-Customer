//
//  OTPViewController.swift
//  Abodle
//
//  Created by mac on 24/11/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    // MARK :- IBOUTLETS
    @IBOutlet weak var txtFieldOTP: DTTextField!
    
    
    //MARK: - Properties
    
    
    
    // MARK :- VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldOTP.delegate = self
        hideKeyboard()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK :- IBACTIONS
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
        if txtFieldOTP.text?.characters.count ==  0 {
            txtFieldOTP.showError(message: "Please enter OTP")
            return
            
        } else {
            
            print("OTP btn clicked")
            
            let data = CoreDataManager.fetch_data_from_CoreData()
            let d = data[0]
            
            let para = ["customer_id":d.customer_id!,"otp":self.txtFieldOTP.text!] as [String : Any]
            verifyOTP(dic: para as NSDictionary)
            
        }
    }

    @IBAction func btnResendOTPClicked(_ sender: Any) {
        print("resend otp btn clicked")
        let data = CoreDataManager.fetch_data_from_CoreData()
        let d = data[0]
        
        let para = ["customer_id":d.customer_id!,"contact_number": d.contact_number!] as [String : Any]
        resendOTP(dic: para as NSDictionary)
    }
   
    @IBAction func btnChangeNumberClicked(_ sender: Any) {
        
        let mVC = storyboard?.instantiateViewController(withIdentifier: "UpdateNumberViewController") as! UpdateNumberViewController
        self.present(mVC, animated: true, completion: nil)
    }
    
}




extension OTPViewController : UITextFieldDelegate {
    
    // MARK - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtFieldOTP {
            
            textField.resignFirstResponder()
            return true
            
        }
        
        return true
    }
}

//MARK: Helper method

extension OTPViewController {
    
    
    func verifyOTP(dic: NSDictionary) {
        
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.VERIFYOTP as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
                self.performSegue(withIdentifier: "gotoModeViewController", sender: self)
            }
        }
    }
    
    func resendOTP(dic: NSDictionary) {
        
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.UPDATEMOBILENO as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
            }
        }
    }
}
