//
//  ViewController.swift
//  Abodle
//
//  Created by mac on 23/11/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    
    // MARK :- IBOUTLETS
    @IBOutlet weak var userNameTextField: DTTextField!
    @IBOutlet weak var passwordTextField: DTTextField!
    
    //MARK: Properties
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var customerArray: [CustomerData] = []
    
    // MARK :- VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        hideKeyboard()
        
        let data = CoreDataManager.fetch_data_from_CoreData()
        
        if data.count != 0 {
            
            self.performSegue(withIdentifier: "gotoModeViewController", sender: self)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK :- IBACTIONS
    @IBAction func forgetPasswordButtonClicked(_ sender: Any) {
    
        print("Forget password")
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        
        if userNameTextField.text?.characters.count == 0 {
            
            userNameTextField.showError(message: "Please enter user name")
            return
            
        } else if passwordTextField.text?.characters.count == 0 {
            
            passwordTextField.showError(message: "Please enter password")
            return
            
        } else {
            
            var userRegistrationDic:[String : Any]?
            
            let data = checkDataType(text: userNameTextField.text!)
            
            if data.rawValue == 1 {
                
                //Login Using Mobiel number
                
                userRegistrationDic = ["user_name": "0"+self.userNameTextField.text!,
                                           "signin_type":1,
                                        "password":MD5(self.passwordTextField.text!).lowercased(),
                                           "device_key":"123456",
                                           "platform_type": 2] as [String : Any]
            } else {
                
                //Login Using Email Address
                
                userRegistrationDic = ["customer_name": self.userNameTextField.text!,
                                           "signin_type":1,
                                        "password":MD5(self.passwordTextField.text!).lowercased(),
                                           "device_key":"123456",
                                           "platform_type": 2] as [String : Any]
            }
            
            userLogin(dic: userRegistrationDic! as NSDictionary)
            
        }
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {}

    //MARK:HelperMethod
    
    func userLogin(dic: NSDictionary) {
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.LOGIN as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
                let res = json?.value(forKey: "response") as! NSDictionary
                
                let customer = Customer(dic: res)
                
                CoreDataManager.saveData_into_CoreData(customer:customer)
                
                self.userNameTextField.text = ""
                self.passwordTextField.text = ""
                
                if customer.isMobVerified == "100" {
                    
                    self.performSegue(withIdentifier: "gotoOTPViewController", sender: self)
                    
                } else {
                    
                    self.performSegue(withIdentifier: "gotoModeViewController", sender: self)
                    
                }
            
            }
        }
    }
    
    //MARK:PrePareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}


extension LoginViewController:UITextFieldDelegate {
    
    //MARK :- UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == userNameTextField {
            
            passwordTextField.becomeFirstResponder()
            
        } else if textField == passwordTextField {
            
            textField.resignFirstResponder()
            
        }
        return true
        
    }
    
}
