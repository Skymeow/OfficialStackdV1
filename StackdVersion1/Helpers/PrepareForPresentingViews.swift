//
//  PrepareForPresentingViews.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/8/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class PrepareForPresentingViews {
    
    static let shared = PrepareForPresentingViews()
    
    public func openInApp(_ urlStr: String, viewController: OpenedViewDelegate, navigationController: UINavigationController?) {
        let vc = WebViewController()
        vc.openedViewdelegate = viewController
        vc.urlStr = urlStr
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func redirectToPodcast(_ urlStr: String) {
        let url = URL(string: urlStr)!
        UIApplication.shared.open(url, options: [:]) { (success) in
            if success {
                print("podcast opened")
            }
        }
    }
}
