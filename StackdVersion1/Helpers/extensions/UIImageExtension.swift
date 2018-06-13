//
//  UIImageExtension.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/6/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    convenience init(view: ListImg) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, view.isOpaque, 0)
        //        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: img!.cgImage!)
    }
}

