//
//  AlertView.swift
//  Satcked
//
//  Created by Sky Xu on 3/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    
    @IBOutlet weak var alertMsg: UILabel!

    func configureView(title: String, at location: CGPoint) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.white
        self.center = location
        self.alertMsg.text = title
    }
    
    func dismiss() {
        self.removeFromSuperview()
    }

}
