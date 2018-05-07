//
//  UIColorExtension.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/6/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb rgbColor: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgbColor >> 16) & 0xFF,
            green: (rgbColor >> 8) & 0xFF,
            blue: rgbColor & 0xFF,
            a: a
        )
    }
}
