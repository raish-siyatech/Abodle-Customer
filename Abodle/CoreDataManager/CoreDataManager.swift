//
//  CoreDataManager.swift
//  CoreDataTest
//
//  Created by mac on 10/11/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    private class func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK:- Creat function for Save Data into CoreData
 
    class func saveData_into_CoreData(customer:Customer) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "CustomerData", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(customer.customerName, forKey: "customer_name")
        managedObject.setValue(customer.email, forKey: "email_id")
        managedObject.setValue(customer.deviceKey, forKey: "device_key")
        managedObject.setValue(customer.plateformType, forKey: "platform_type")
        managedObject.setValue(customer.countryCode, forKey: "country_code")
        managedObject.setValue(customer.contactNumber, forKey: "contact_number")
        managedObject.setValue(customer.customerId, forKey: "customer_id")
        managedObject.setValue(customer.authenticationKey, forKey: "authenticationKey")
        managedObject.setValue(customer.authenticationValue, forKey: "authenticationValue")
        managedObject.setValue(customer.isMobVerified, forKey: "isMobVerified")
        managedObject.setValue(customer.customerStatus, forKey: "customer_status")
        managedObject.setValue(customer.imageUrl, forKey: "image_url")
        
        do {
            
            try context.save()
            print("SAVE DATA SUCCESSFULLY")
            
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    //MARK : - Creat function for Fetch Data from CoreData
    
    class func fetch_data_from_CoreData() -> [CustomerData] {
        
        var dataArray = [CustomerData]()
        
        let fetchRequest: NSFetchRequest<CustomerData> = CustomerData.fetchRequest()
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for data in fetchResult {
                
                let customer = data as CustomerData
                
                let entity = customer
                dataArray.append(entity)
            }
            
        } catch {
            
            print("error while fetching data")
        }
        
        for data in dataArray {
            print(data.authenticationValue!)
            print(data.contact_number!)
            print(data.customer_id!)
            print(data.customer_name!)
            print(data.customer_status!)
            print(data.email_id!)
            print(data.image_url!)
            print(data.isMobVerified!)
        }
        return dataArray
        
    }
    
    //MARK: Create function for deleteDataFromCoreData

    class func delete_data_from_CoreData() -> Void {
        
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<CustomerData> = CustomerData.fetchRequest()
        
        do {
            
            let fetchResult = try getContext().fetch(fetchRequest)
            
        
            for data in fetchResult {
                
                getContext().delete(data)
                
            }
            
            do {
                
                try context.save()
                print("SAVE DATA SUCCESSFULLY")
                
            } catch {
                
                print(error.localizedDescription)
            }
            
            
        } catch {
            
            print("error while deleting data from CoreData")
        }
    }
    
    //MARK: Create function for updateData_into_CoreData
    
    class func updateDataIntoCoreData(customer:Customer) {
        
        var dataArray = [CustomerData]()
        let context = getContext()
        
        let fetchRequest: NSFetchRequest<CustomerData> = CustomerData.fetchRequest()
        
        do {
            
            dataArray = try getContext().fetch(fetchRequest)
            
            if dataArray.count > 0 {
                
                let d = dataArray[0]
                
                d.setValue(customer.customerStatus, forKey: "customer_status")
                d.setValue(customer.imageUrl, forKey: "image_url")
                d.setValue(customer.authenticationKey, forKey: "authenticationKey")
                d.setValue(customer.authenticationValue, forKey: "authenticationValue")
                d.setValue(customer.isMobVerified, forKey: "isMobVerified")
                
                do {
                    
                    try context.save()
                    print("SAVE DATA SUCCESSFULLY")
                    
                } catch {
                    
                    print(error.localizedDescription)
                }
                
            }
            
        } catch {
            
            print("error while updating data")
        }
    }
 }


