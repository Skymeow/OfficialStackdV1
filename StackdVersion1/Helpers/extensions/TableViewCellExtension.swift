//
//  TableViewCellExtension.swift
//  StackdVersion1
//
//  Created by Sky Xu on 6/4/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func shakeCell(duration: CFTimeInterval = 0.3, pathLength: CGFloat = 2) {
        let position: CGPoint = self.center
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: position.x, y: position.y))
        path.addLine(to: CGPoint(x: position.x, y: position.y - pathLength))
        path.addLine(to: CGPoint(x: position.x, y: position.y + pathLength))
        path.addLine(to: CGPoint(x: position.x, y: position.y - pathLength))
        path.addLine(to: CGPoint(x: position.x, y: position.y + pathLength))
        path.addLine(to: CGPoint(x: position.x, y: position.y))
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = path.cgPath
        positionAnimation.duration = .infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        CATransaction.begin()
        self.layer.add(positionAnimation, forKey: nil)
        CATransaction.commit()
        
    }
    
    func removeShakeAnimation(positionAnimation: CAKeyframeAnimation) {
        self.layer.removeAnimation(forKey: "position")
    }
    
}
