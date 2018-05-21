//
//  Storyboad & Utility.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    enum StorybooardType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: StorybooardType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    static func initialViewController(for type: StorybooardType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
