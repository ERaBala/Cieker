//
//  TextFieldStyle.swift
//  Cieker
//
//  Created by Bala on 21/08/16.
//  Copyright © 2016 bala. All rights reserved.
//

import UIKit

class TextFieldStyle: UITextField {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 5.0;
        self.layer.borderColor = UIColor(red: 0.94, green: 0.58, blue: 0.20, alpha: 1).CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.whiteColor()
        self.textColor = UIColor.whiteColor()
        self.tintColor = UIColor.purpleColor()
        
    }

}
