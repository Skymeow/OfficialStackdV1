//
//  AlertView.swift
//  Satcked
//
//  Created by Sky Xu on 3/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class FadingAlertView: UIView {
    
    
    @IBOutlet weak var stackImg: UIImageView!
    @IBOutlet weak var alertMsg: UILabel!
    
    func configureView(title: String, at location: CGPoint) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.stackImg.image = #imageLiteral(resourceName: "confirm_action")
        self.center = location
        self.alertMsg.text = title
        self.alertMsg.font = UIFont(name: "SFProDisplay-Medium", size: 17)
    }
    
    func dismiss() {
        self.removeFromSuperview()
    }
    
    func show() {
        UIView.animate(withDuration: 2, delay: 2, options: [], animations: {
            self.alpha = 1
        }) { (completed) in
            print("view appear animate completed")
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 1.2, delay: 3, options: [], animations: {
            self.alpha = 0
        }) { (completed) in
                self.removeFromSuperview()
        }
    }

}
