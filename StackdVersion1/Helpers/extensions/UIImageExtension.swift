//
//  UIImageExtension.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/6/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
}
}
