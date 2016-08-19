//
//  ViewController.swift
//  Cieker
//
//  Created by User on 18/08/16.
//  Copyright © 2016 bala. All rights reserved.
//
import Foundation
import UIKit

// Tab Buttons

class ViewController: UIViewController, ENSideMenuDelegate, UITabBarDelegate, UITabBarControllerDelegate {


    @IBOutlet weak var TabBar: UITabBar!
    @IBOutlet weak var hubTabBar: UITabBarItem!
    @IBOutlet weak var ScoopsTabBar: UITabBarItem!
    @IBOutlet weak var TeamTabBar: UITabBarItem!
    @IBOutlet weak var QATabBar: UITabBarItem!
    @IBOutlet weak var ChatTabBar: UITabBarItem!
    @IBOutlet weak var JobsTabBar: UITabBarItem!
    @IBOutlet weak var TutorialTabBar: UITabBarItem!
    @IBOutlet weak var WebViewControl: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sideMenuController()?.sideMenu?.delegate = self
        webview("https://www.cieker.com")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //set inital view
        
    }
    
    func webview(URL: String){
        let url = NSURL (string: URL);
        let requestObj = NSURLRequest(URL: url!);
        WebViewControl.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Slidertoggle(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
       
        switch (item.tag) {
        case 1:
            webview("https://www.cieker.com")
        case 2:
            webview("https://www.cieker.com/scoops.php")
        case 3:
           webview("https://www.cieker.com/teams.php")
        case 4:
            webview("https://www.cieker.com/qanda.php")
        case 5:
            webview("https://www.cieker.com/chat.php")
        case 6:
            webview("https://www.cieker.com/jobs.php")
        case 7:
            webview("https://www.cieker.com/Tutorial.php")
        default:
            break
        }
    }
    
    // UITabBarControllerDelegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
    }


    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }

}

