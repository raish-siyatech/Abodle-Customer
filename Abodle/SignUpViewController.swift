//
//  SignUpViewController.swift
//  Abodle
//
//  Created by mac on 23/11/17.
//  Copyright © 2017 Siyatech Ventures. All rights reserved.
//

import UIKit
import CoreData


class SignUpViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var textName: DTTextField!
    @IBOutlet weak var textEmail: DTTextField!
    @IBOutlet weak var textMobile: DTTextField!
    @IBOutlet weak var textPassword: DTTextField!
    @IBOutlet weak var buttonTermCondition: UIButton!
    var terms: Bool?
    
    // MARK :- VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
        terms = true
        self.navigationController?.navigationBar.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    //MARK: Button Action 
    @IBAction func buttonTermsConditioniTapped(_ sender: UIButton) {
        
        if terms! {
            
            self.buttonTermCondition.isSelected = true
            terms = false
            
        } else {
            
            self.buttonTermCondition.isSelected = false
            terms = true
            
        }
    }
    
    
    @IBAction func gestureTappedforSignUp(_ sender: UITapGestureRecognizer) {
        
        if self.buttonTermCondition.isSelected == false {
            
            print("Please check terms & condition")
            return
            
        } else if self.textName.text?.characters.count == 0 {
            
            textName.showError(message: "Please enter Username")
            return
            
        } else if !isEmailValid(testStr: self.textEmail.text!) {
            
            textEmail.showError(message: "Please enter valid email address")
            return
            
        } else if (self.textMobile.text?.characters.count)! == 0 && (self.textMobile.text?.characters.count)! != 10 {
            
            textMobile.showError(message: "Please enter 10 digit mobile number")
            return
            
        } else if (self.textPassword.text?.characters.count)! == 0 && (self.textPassword.text?.characters.count)! < 6 {
            
            textPassword.showError(message: "Password should not be less than six digits")
            return
            
        } else {
            
            let userRegistrationDic = ["customer_name": self.textName.text!,
                                       "email_id":self.textEmail.text!,
                                       "password":MD5(self.textPassword.text!).lowercased(),
                                       "device_key":"123456",
                                       "platform_type": 2,
                                       "contact_number":"0" + "\(self.textMobile.text!)",
                                       "country_code":"91"] as [String : Any]
            
            userSignup(dic: userRegistrationDic as NSDictionary)
            
        }
    }
    
    @IBAction func buttonLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


//MARK:UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate  {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textName {
            
            textEmail.becomeFirstResponder()
            
        } else if textField == textEmail {
            
            textMobile.becomeFirstResponder()
            
        } else if textField == textMobile {
            
            textPassword.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
        }
        
        return true
    }
    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        
//        if textField == textMobile {
//            
//            self.textMobile.text = "(0)"
//            
//        }
//        return true
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if range.length>0  && range.location == 2 {
//            return false
//        }
//        return true
//    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if range.length>0  && range.location == 0 {
//            let changedText = NSString(string: self.textMobile.text!).substring(with: range)
//            if changedText.contains("(0)") {
//                return false
//            }
//        }
//        return true
//    }
}

//MARK: Helper method

extension SignUpViewController {
    
    func userSignup(dic: NSDictionary) {
        
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.SIGNUP as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
                let res = json?.value(forKey: "response") as! NSDictionary
                let customer = Customer(dic: res)
                
                CoreDataManager.saveData_into_CoreData(customer:customer)
                
                self.performSegue(withIdentifier: "gotoOTPViewController", sender: self)
                
            }
        }
    }
}
