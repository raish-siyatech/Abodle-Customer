//
//  ModeViewController.swift
//  Abodle
//
//  Created by mac on 24/11/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

class ModeViewController: UIViewController {

    @IBOutlet weak var txtFieldLocation: DTTextField!
    
    //MARK: Properties
    
    var name:String!
    var address:String!
    var latitude:Double = 0.0
    var longitude:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK :- IBACTIONS
    @IBAction func btnTravelModeClicked(_ sender: Any) {
        
        if txtFieldLocation.text?.characters.count == 0 {
            txtFieldLocation.showError(message : "Please select location")
            return
        }
        print("travel mode")
        
    }

    @IBAction func btnPropertyModeClicked(_ sender: Any) {
        
        if txtFieldLocation.text?.characters.count == 0 {
            txtFieldLocation.showError(message : "Please select location")
            return
        }
        print("property mode")
        
    }

    @IBAction func buttonLogout(_ sender: UIButton) {
        
        let data = CoreDataManager.fetch_data_from_CoreData()
        let d = data[0]
        let para = ["customer_id" : d.customer_id]
        
        self.userLogOut(dic: para as NSDictionary)
    }
    
}

//MARK: UITextFieldDelegate

extension ModeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.txtFieldLocation {
            
            self.view.endEditing(true)
            self.selectAddress()
            return false
        }
        
        return true
    }
}

//MARK: Helper method

extension ModeViewController {
    
    func userLogOut(dic: NSDictionary) {
        
        LoadingIndicatorView.show()
        
        NetworkManager.sharedInstance.executeServiceWithURL(urlString: WEB_URL.LOGOUT as String, postParameters: dic as NSDictionary) { (json, jsonError) in
            LoadingIndicatorView.hide()
            
            if (json?["status"] as! Bool) == true {
                
                CoreDataManager.delete_data_from_CoreData()
                
                self.navigationController?.popToRootViewController(animated: true)
                
            }
        }
    }
}

//MARK: Helper method

extension ModeViewController {
    
    func selectAddress() {
        
        //MARK: - Google Place picker
        
        let center = CLLocationCoordinate2D(latitude: 37.788204, longitude: -122.411937)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePicker(config: config)
        
        
        placePicker.pickPlace(callback: {(place, error) -> Void in
            
            if let error = error {
                return
            }
            
            if let place = place {
                
                self.name = place.name
                self.address = place.formattedAddress?.components(separatedBy: ", ")
                    .joined(separator: "\n")
                self.latitude = place.coordinate.latitude
                self.longitude = place.coordinate.longitude
                
                self.txtFieldLocation.text = "\(self.name!)" + "\(self.address!)"
                
            } else {
                
                self.name = "No place selected"
                self.address = ""
                self.txtFieldLocation.text = "\(self.name!)" + "\(self.address!)"
                
            }
        })
    }
}
