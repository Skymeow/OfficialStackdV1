//
//  AlertView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/18/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class AlertView {
    static let instance = AlertView()
    
    func presentAlertView(_ message: String, _ superview: UIViewController) {
        let alert = UIAlertController(title: "Action Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        superview.present(alert, animated: true)
    }
    
}

