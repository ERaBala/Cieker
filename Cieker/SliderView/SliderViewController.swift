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
    
    var aData : [String] = ["bala","jeva","seetha"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            "Cell", forIndexPath: indexPath)
       
        return aCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
    }


}

// color code of Screen 	R: 135 G: 197 B: 184