//
//  NetworkManager.swift
//  RewinrApp_Swift
//
//  Created by Mohammed Hussain on 26/05/16.
//  Copyright © 2016 Applanche. All rights reserved.
//

import Foundation

class NetworkManager:NSObject {
    
    static let sharedInstance = NetworkManager()
    private var jsonStrings:String?
    
    func executeServiceWithURL(urlString:String,postParameters:NSDictionary?,callback:@escaping (_ json:NSDictionary?,_ taskError:NSError?)->Void) {
        
        print("URL -: \(urlString)")
        
        if (postParameters != nil) {
            
            do {
                print("Parameters -: \(postParameters!)")
                let json = try JSONSerialization.data(withJSONObject: postParameters!, options: JSONSerialization.WritingOptions.prettyPrinted)
                jsonStrings  = String(data: json,encoding: String.Encoding.utf8)!
                
            } catch let error as NSError {
                print(error)
            }
        }
       
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.httpBody = jsonStrings?.data(using: String.Encoding.utf8)
        
        if urlString == (WEB_URL.SIGNUP) as String || urlString == (WEB_URL.LOGIN) as String {
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            
//            let user = AppShareData.sharedInstance.getUser()
        
//            let apikey = user?.apiKey
//            let apivalue = user?.apiValue
            
//            if  user != nil {
//                request.addValue("1234", forHTTPHeaderField: apikey!)
//            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let dataTask = session.dataTask(with: request as URLRequest) { (taskData, taskResponse, taskError) in
            
            DispatchQueue.main.async {
                
                do {
                    
                    if let tData = taskData {
                       
                        let json = try JSONSerialization.jsonObject(with: tData, options: .mutableContainers) as? NSDictionary
                        print("JSON :- \(json!)")
                        callback(json!, nil)

                    }
                    
                } catch let error as NSError {
                    
                    callback(nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
}
