//
//  CustomPage.swift
//  onboardingtest
//
//  Created by Sky Xu on 6/5/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import SwiftyOnboard
import Gifu

class CustomPage: SwiftyOnboardPage {
    
    @IBOutlet weak var gifImg: GIFImageView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomPage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
