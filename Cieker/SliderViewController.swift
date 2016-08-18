//
//  SliderViewController.swift
//  Cieker
//
//  Created by User on 18/08/16.
//  Copyright © 2016 bala. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet weak var TabelView: UITableView!
    @IBOutlet weak var ProfilePicImageView: UIImageView!
    
     let aData : NSArray = ["First","Second","Third"]
    override func viewDidLoad() {
        super.viewDidLoad()
     self.TabelView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCellWithIdentifier(
            "kCell", forIndexPath: indexPath)
//        let aLabel : UILabel = aCell.viewWithTag(10) as! UILabel
//        aLabel.text = aData[indexPath.row] as? String
        return aCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            kConstantObj.SetIntialMainViewController("firstVC") // firstVC is storyboard ID
        }else if indexPath.row == 1 {
            kConstantObj.SetIntialMainViewController("secondVC")
        }else if indexPath.row == 2 {
            kConstantObj.SetIntialMainViewController("thirdVC")
        }
    }


}

// color code of Screen 	R: 135 G: 197 B: 184