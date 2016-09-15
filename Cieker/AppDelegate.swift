//
//  AppDelegate.swift
//  Cieker
//
//  Created by User on 18/08/16.
//  Copyright © 2016 bala. All rights reserved.
//
import Foundation
import UIKit
import Google
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate  {

    var window: UIWindow?
    
    var connectedToGCM = false
    var subscribedToTopic = false
    var gcmSenderID: String?
    var registrationToken: String?
    var registrationOptions = [String: AnyObject]()
    
    let registrationKey = "onRegistrationCompleted"
    let messageKey = "onMessageReceived"
    let subscriptionTopic = "/topics/global"
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [NSObject: AnyObject]?) -> Bool {
        
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
        

        if #available(iOS 8.0, *) {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            // Fallback
            let types: UIRemoteNotificationType = [.Alert, .Badge, .Sound]
            application.registerForRemoteNotificationTypes(types)
        }
        
        let DarkColor = UIColor.init(red: 40, green: 175, blue: 161, alpha: 1.0)
        let gcmConfig = GCMConfig.defaultConfig()
        gcmConfig.receiverDelegate = self
        GCMService.sharedInstance().startWithConfig(gcmConfig)
        
        
        // ================= Status View ================= //
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
        view.backgroundColor = UIColor(red: 40, green: 175, blue: 161, alpha: 1.0)
        self.window!.rootViewController!.view.addSubview(view)
        sleep(3)
        
        return true
    }
    
    func subscribeToTopic() {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the
        // topic
        if(registrationToken != nil && connectedToGCM) {
            GCMPubSub.sharedInstance().subscribeWithToken(self.registrationToken, topic: subscriptionTopic,
                                                          options: nil, handler: {(error:NSError?) -> Void in
         if let error = error {
              // Treat the "already subscribed" error more gently
            if error.code == 3001 {
                print("Already subscribed to \(self.subscriptionTopic)")
            } else {
                print("Subscription failed: \(error.localizedDescription)");
            }
            } else {
                self.subscribedToTopic = true;
                NSLog("Subscribed to \(self.subscriptionTopic)");
            }
            })
        }
    }
    
    // [START connect_gcm_service]
    func applicationDidBecomeActive( application: UIApplication) {
        // Connect to the GCM server to receive non-APNS notifications
        GCMService.sharedInstance().connectWithHandler({(error:NSError?) -> Void in
            if let error = error {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
                self.connectedToGCM = true
                print("Connected to GCM")
                self.subscribeToTopic()
            }
        })
    }
    // [END connect_gcm_service]
    
    
    // [START disconnect_gcm_service]
    func applicationDidEnterBackground(application: UIApplication) {
        GCMService.sharedInstance().disconnect()
        // [START_EXCLUDE]
        self.connectedToGCM = false
        // [END_EXCLUDE]
    }
    // [END disconnect_gcm_service]
    
    
    // [START receive_apns_token]
    func application( application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: NSData ) {
        // [END receive_apns_token]
        // [START get_gcm_reg_token]
        // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
        let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
        instanceIDConfig.delegate = self
        // Start the GGLInstanceID shared instance with that config and request a registration
        // token to enable reception of notifications
        GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
        registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken,
                               kGGLInstanceIDAPNSServerTypeSandboxOption:true]
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                                                                 scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
        // [END get_gcm_reg_token]
    }
    
    // [START receive_apns_token_error]
    func application( application: UIApplication, didFailToRegisterForRemoteNotificationsWithError
        error: NSError ) {
        print("Registration for remote notification failed with error: \(error.localizedDescription)")
        // [END receive_apns_token_error]
        let userInfo = ["error": error.localizedDescription]
        NSNotificationCenter.defaultCenter().postNotificationName(
            registrationKey, object: nil, userInfo: userInfo)
    }
    
    // [START ack_message_reception]
    func application( application: UIApplication,
                      didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("Notification received: \(userInfo)")
        let aps = userInfo["message"] as! String
        Aleartmessage(aps)
        print("message: \(aps)")
        
        // This works only if the app started the GCM service
        GCMService.sharedInstance().appDidReceiveMessage(userInfo);
        // Handle the received message
        // [START_EXCLUDE]
        NSNotificationCenter.defaultCenter().postNotificationName(messageKey, object: nil,
                                                                  userInfo: userInfo)

        // [END_EXCLUDE]
    }
    
    
    func Aleartmessage(userinfo : NSString)  {

        let localNotification = UILocalNotification()
        localNotification.soundName = UILocalNotificationDefaultSoundName //If you want an alert sound.
        localNotification.alertBody = userinfo as String //Put your notification message here
        localNotification.applicationIconBadgeNumber += 1 //Change what the badge number should be
        
        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
      
    }
    
    func application( application: UIApplication,
                      didReceiveRemoteNotification userInfo: [NSObject : AnyObject],
                                                   fetchCompletionHandler handler: (UIBackgroundFetchResult) -> Void) {
        print("Notification received: \(userInfo)")
        
        let aps = userInfo["message"] as! String
         Aleartmessage(aps)
        print("message: \(aps)")
        
        // This works only if the app started the GCM service
        GCMService.sharedInstance().appDidReceiveMessage(userInfo);
        // Handle the received message
        // Invoke the completion handler passing the appropriate UIBackgroundFetchResult value
        // [START_EXCLUDE]
        NSNotificationCenter.defaultCenter().postNotificationName("message", object: nil,
                                                                  userInfo: userInfo)
        handler(UIBackgroundFetchResult.NoData);
        // [END_EXCLUDE]
    }
    // [END ack_message_reception]
    
    func registrationHandler(registrationToken: String!, error: NSError!) {
        if (registrationToken != nil) {
            self.registrationToken = registrationToken
            print("Registration Token: \(registrationToken)")
            
            let Token = "https://www.cieker.com/index.php?gcm=\(registrationToken)&mob=ios"
            FormGlobal.UserDefaultFunction(defaultName: Token, defaultKey: "DeviceToken") .NSStringForKey()
            
            JSONMethod(registrationToken)
            
            print(Token)
            self.subscribeToTopic()
            let userInfo = ["registrationToken": registrationToken]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        } else {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NSNotificationCenter.defaultCenter().postNotificationName(
                self.registrationKey, object: nil, userInfo: userInfo)
        }
    }
    
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                                                                 scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: registrationHandler)
    }
    // [END on_token_refresh]
    
    // [START upstream_callbacks]
    func willSendDataMessageWithID(messageID: String!, error: NSError!) {
        if (error != nil) {
            // Failed to send the message.
        } else {
            // Will send message, you can save the messageID to track the message
        }
    }
    
    func JSONMethod( parameters: AnyObject ) {
        let  url =  NSURL(string:"https://www.cieker.com/regis.php?gcm=")
        
        Alamofire.request(.POST, url!, parameters: parameters as? [String : AnyObject], encoding:.JSON).responseJSON
            { response in
                switch response.result {
                case .Success(let JSON):
                    print("Success with JSON: \(JSON)")
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
    }
    
    
    func didSendDataMessageWithID(messageID: String!) { }
    
    func didDeleteMessagesOnServer() { }
    
    func applicationWillResignActive(application: UIApplication) { }

    func applicationWillEnterForeground(application: UIApplication) { }

    func applicationWillTerminate(application: UIApplication) { }

}


