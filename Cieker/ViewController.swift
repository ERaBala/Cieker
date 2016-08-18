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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "Nav-bar-1.png")!, forBarMetrics: .Default)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Slidertoggle(sender: AnyObject) {
        sideMenuVC.toggleMenu()
    }

}

