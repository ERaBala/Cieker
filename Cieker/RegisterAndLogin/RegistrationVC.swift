//
//  RegistrationVC.swift
//  Cieker
//
//  Created by Bala on 21/08/16.
//  Copyright © 2016 bala. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var PushNotificationText: UITextView!
    @IBOutlet weak var textviewvalue: UITextView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        if let name = defaults.stringForKey("DeviceToken"){
            
            self.textviewvalue.text = name
            
        }else{
            
        self.textviewvalue.text = "YOUR UDID IS NOT IN APNS / CHECK YOUR CONNECTION /  REMOTE_NOTIFICATION_NOT_SUPPORTED_NSERROR_DESCRIPTION"
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Button(sender: AnyObject) {
        
        let name = defaults.stringForKey("Push")
        self.PushNotificationText.text = name
        
    }

    /*
     
     if txtEmail.text?.isEmpty == true || txtPassword.text?.isEmpty == true || txtRePassword.text?.isEmpty == true{
     print("true")
     }
     
    */

}
