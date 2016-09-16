//
//  FormGlobal.swift
//  Cieker
//
//  Created by Bala on 19/08/16.
//  Copyright © 2016 bala. All rights reserved.
//

import UIKit

class FormGlobal: NSObject {
    
    struct  UserDefaultFunction {
        
        var defaultName: String
        var defaultKey: String
        
        func NSStringForKey()
        {
            NSUserDefaults.standardUserDefaults().setObject(defaultName, forKey: defaultKey)
            //  InGlobalFile.UserDefaultFunction(defaultName: deviceTokenString, defaultKey: "DeviceToken") .NSStringForKey()  // include this
        }
    }
    
    struct Aleart {
        
        var Title: String
        var Message: String
        var btnTitle: String
        
        func ShowAleartFunction()
        {
            let alert = UIAlertView()
            alert.title = Title
            alert.message = Message 
            alert.addButtonWithTitle(btnTitle)
            alert.show()
        }
    }
    

//    GCM :
//    
//    Server API Key : AIzaSyCUHXQwkSFa0EaaAQ8udBov24sCQt31UU4
//    Sender ID : 882488677884
}