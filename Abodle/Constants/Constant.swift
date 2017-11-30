//
//  Constant.swift
//  RewinrApp_Swift
//
//  Created by Mohammed Hussain on 26/05/16.
//  Copyright © 2016 Applanche. All rights reserved.
//

import UIKit
//255 57 102

struct WEB_URL {
    
    static let BaseURL:NSString = "http://91.134.134.236/abodle-new/index.php/"
    
    static let LOGIN:NSString = "\(BaseURL)Customer/Signin/login" as NSString
    static let SIGNUP:NSString = "\(BaseURL)Customer/Register/signUp" as NSString
    static let VERIFYOTP:NSString = "\(BaseURL)Customer/Signin/verifyOtp" as NSString
    static let LOGOUT:NSString = "\(BaseURL)Customer/Signin/logout" as NSString
    static let UPDATEMOBILENO:NSString = "\(BaseURL)Customer/Signin/VerifyNumber" as NSString
}

enum TaskType:String {
    
    case TaskTypeLogin,TaskTypeSignUp
}


//MARK: Check Valid Email

func isEmailValid(testStr:String) -> Bool {
    let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
}


//MARK: Datatype specifier
enum DataType: Int {
    case Number = 1
    case Email = 2
}

//MARK: Check Datatype
func checkDataType(text: String)-> DataType {
    if Int(text) != nil {
        return DataType.Number
    } else {
        return DataType.Email
    }
}

/*

struct THEME_COLOR {
    static let nav_bar_color:UIColor = UIColor(red: 239/255, green: 62/255, blue: 74/255, alpha: 1)
    static let APP_TINT_COLOR:UIColor     = UIColor(red: 239/255, green: 236/255, blue: 238/255, alpha: 1)
    static let APP_TEXT_TINT_COLOR:UIColor = UIColor(red:  78/255, green: 101/255, blue: 115/255, alpha: 1)
    static let orange:UIColor    = UIColor(red: 255/255, green: 112/255, blue: 0/255, alpha: 1)
    static let CARD_TEXT_COLOR:UIColor    = UIColor(red: 0/255, green: 161/255, blue: 174/255, alpha: 1)
    static let REQUEST_BACKGROUND_COLOR = UIColor(red: 239/255, green:62/255, blue:74/255, alpha: 1)
    static let REQUEST_REPAIR_COLOR = UIColor(red: 82/255, green:143/255, blue:225/255, alpha: 1)

}

let BLUE_COLOR = UIColor.init(red: 82.0/255.0, green: 143.0/255.0, blue: 225.0/255.0, alpha: 1.0)
let RED_COLOR = UIColor.init(red: 239.0/255.0, green: 62.0/255.0, blue: 74.0/255.0, alpha: 1.0)

let TIME_FORMAT = "HH:mm:ss"
let TIME_FORMAT_AM = "hh:mm a"

let DATE_FORMAT_WITHTIME = "dd.MM.yyyy HH:mm:ss"

let DATE_FORMAT_WITHOUTTIME = "dd.MM.yyyy"

let WEB_DATE_FORMAT_WITHTIME = "yyyy-MM-dd HH:mm:ss"
let WEB_DATE_FORMAT_WITHOUTTIME = "yyyy-MM-dd"

//let appSharedData = AppShareData.sharedInstance
let networkManager = NetworkManager.sharedInstance
let UserDefault = UserDefaults.standard

let SIGN_UP_TYPE_REGISTER = "1"
let USERID:NSString! = "UserId"
let UD_MECHANIC:NSString! = "UD_USER"
let UD_NOTIF_REPAIR:NSString! = "UD_NOTIF_REPAIR"

let PLATFORM_TYPE_IOS = "2"
let EVENT_TYPE_FEATURE = "1"
let EVENT_TYPE_PRIVATE = "2"
let EVENT_TYPE_LOOKING_FOR = "3"
let GOOGLE_PLACES_API_KEY = "AIzaSyBslFS5s_f3qOBWqrguaBt_buY_n1BFUUQ"
let DID_CARD_GENERATED = "DID_CARD_GENERATED"

let NOTIF_DID_CHANGE_ADDRESS = "NOTIF_DID_CHANGE_ADDRESS"
let NOTIF_DID_CREATED_EVENT = "NOTIF_DID_CREATED_EVENT"
let NOTIF_MECHANIC_LOGOUT = "NOTIF_MECHANIC_LOGOUT"
let NOTIF_EDIT_PROFILE = "NOTIF_EDIT_PROFILE"
let NOTIF_DID_ACCEPT_REPAIR_REQUEST = "NOTIF_DID_ACCEPT_REPAIR_REQUEST"
let LOCAL_NOTIF_REPIAR = "LOCAL_NOTIF_REPIAR"

// Define identifier

let notificationName = Notification.Name("NotificationIdentifier")

enum NotifType:Int {
    
    case Initialization = 1
    case Accepted = 2
    case Rejected = 3
    case Cancel_By_User = 4
    case Cancel_By_Mech = 5
    case Complete = 6
    case No_Driver_Found = 7
    case Complete_By_Mechanic = 8
    case Arrive = 9
    
}

struct MechStatus {
    
    static func getMechanicStatus(reqStatus:Int) -> String {
        
        switch reqStatus {
            
        case NotifType.Initialization.rawValue:
            return "Initialization"
            
        case NotifType.Accepted.rawValue:
            return "Accepted"
            
        case NotifType.Rejected.rawValue:
            return "Rejected"
            
        case NotifType.Cancel_By_User.rawValue:
            return "Cancel By User"
            
        case NotifType.Cancel_By_Mech.rawValue:
            return "Cancel By Mechanic"
            
        case NotifType.Complete.rawValue:
            return "Complete"
            
        case NotifType.No_Driver_Found.rawValue:
            return "No Driver Found"
            
        case NotifType.Complete_By_Mechanic.rawValue:
            return "Complete By Mechanic"
            
        case NotifType.Arrive.rawValue:
            return "Arrive"
            
        default:
            return ""
        }
    }
}


enum AvailabiltyType:Int {

    case AvailabilityTypeUpdateDelete,
    AvailabilityTypeAdd
}

struct SCREEN {
    static let width:CGFloat   = UIScreen.main.bounds.width
    static let height:CGFloat  = UIScreen.main.bounds.height
}

struct FONTS {
    static let BOLD:NSString = "OpenSans-Bold"
    static let REGULAR:NSString = "OpenSans"
    static let SEMIBOLD:NSString = "OpenSans-Semibold"
    static let ITALIC:NSString = "OpenSans-Italic"
}

struct SIGN_UP_TYPE {
    static let NORMAL:NSString = "1"
    static let GOOGLE:NSString = "2"
    static let FACEBOOK:NSString = "3"
}

struct DEVELOPMENT_MODE {
    static let PRODUCTION:NSString = "101"
    static let DEVELOPEMNT:NSString = "100"
}

struct Device_Key{
//    static let device_key = AppDelegate.getAppDelegate().gottedDeviceToken
}

struct REQUEST_TYPE {
    static let EMERGENCY:NSString = "2"
    static let REPAIR:NSString = "1"
} 

 */
