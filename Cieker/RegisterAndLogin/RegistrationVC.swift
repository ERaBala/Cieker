//
//  RegistrationVC.swift
//  Cieker
//
//  Created by Bala on 21/08/16.
//  Copyright © 2016 bala. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var textviewvalue: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let name = defaults.stringForKey("DeviceToken"){
            
            self.textviewvalue.text = "u did not get Device value Check ur Identifier"
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
    

    /*
     
     if txtEmail.text?.isEmpty == true || txtPassword.text?.isEmpty == true || txtRePassword.text?.isEmpty == true{
     print("true")
     }
     
    */

}
