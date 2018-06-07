//
//  OnboardingPageViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//
import Foundation
import UIKit
import SwiftyOnboard

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyOnboard.dataSource = self
        swiftyOnboard.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSkip() {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}

extension OnboardingViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let page = CustomPage.instanceFromNib() as? CustomPage
        page?.gifImg.animate(withGIFNamed: "gif\(index)") {
        }
        
        return page
    }
    
    //    add action for butoons
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        return overlay
    }
    
    //    UI layer for buttons
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        //        overlay.skip.tag = Int(position)
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.skip.setTitle("Got it", for: .normal)
            overlay.skip.contentHorizontalAlignment = .center
        } else {
            overlay.skip.setTitle("Start Stacking", for: .normal)
            overlay.skip.contentHorizontalAlignment = .center
        }
    }
}

