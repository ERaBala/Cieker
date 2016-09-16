//
//  ViewController.swift
//  Cieker
//
//  Created by User on 18/08/16.
//  Copyright © 2016 bala. All rights reserved.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CiekerWebView: UIWebView!
    @IBOutlet weak var BackButtonoutlet: UIButton!
    @IBOutlet weak var imageviewBackground: UIImageView!
    
    var flag : Int = 1
    var stringConvertionURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackButtonoutlet.hidden = true
        print("error ======================")
        let DeviceToken = NSUserDefaults.standardUserDefaults().objectForKey("DeviceToken")
        print(DeviceToken)
        if DeviceToken != nil {
            stringConvertionURL = DeviceToken as! String
//            Aleartmessage(stringConvertionURL)
            flag = 0
            webview(stringConvertionURL)

        }
        else if (flag == 1) {
            stringConvertionURL = "https://www.cieker.com/"
            flag = 1
            webview(stringConvertionURL)
        }
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.handleSwipes(_:)))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
    }
    
    func Aleartmessage(userinfo : AnyObject)  {
        
        let Message = userinfo as! String
        FormGlobal.Aleart(Title: "PushNotification", Message: Message, btnTitle: "ok") .ShowAleartFunction()
    }

    
    func webview(URL: String){
        CiekerWebView.loadRequest(NSURLRequest(URL: NSURL(string: URL)!))
    }
    
    func webView(CiekerWebView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        if navigationType == UIWebViewNavigationType.LinkClicked {
////            UIApplication.sharedApplication().openURL(request.URL!)
//            return false
//        }
        return true
    }

//    func webViewDidStartLoad(CiekerWebView: UIWebView) {
//            BackButtonoutlet.hidden = true
//    }
    
    func webViewDidFinishLoad(CiekerWebView: UIWebView)
    {
        
//         UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        // Disable user selection
    CiekerWebView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitUserSelect='none'")!
        // Disable callout
    CiekerWebView.stringByEvaluatingJavaScriptFromString("document.documentElement.style.webkitTouchCallout='none'")!
        let currentURL = CiekerWebView.request!.mainDocumentURL
        print("\(currentURL)")
        let urlString: String = currentURL!.absoluteString
        if (urlString.rangeOfString("googleapis") != nil) || (urlString.rangeOfString("facebook.com") != nil){
            print("================= google & Facebook =================")
            BackButtonoutlet.hidden = false
        
        }
        else if (urlString.rangeOfString("cieker.com") != nil) || (urlString.rangeOfString("www.cieker.com") != nil){
            print("++++++++++++++++++ google page ++++++++++++++++++")
            BackButtonoutlet.hidden = true
        }
        else {
            print("******************** something ********************")
            BackButtonoutlet.hidden = false
        }
    }
    
    @IBAction func BackButton(sender: AnyObject) {
        if(CiekerWebView.canGoBack) {
            CiekerWebView.goBack()
        }
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            print("Swipe Left")
            if(CiekerWebView.canGoForward) {
                CiekerWebView.goForward()
            }
        }
        
        if (sender.direction == .Right) {
            print("Swipe Right")
            if(CiekerWebView.canGoBack) {
                CiekerWebView.goBack()
            }
        }
    }
    
}

