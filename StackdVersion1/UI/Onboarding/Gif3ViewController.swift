//
//  Gif3ViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import Gifu

class Gif3ViewController: UIViewController {

    @IBOutlet weak var gifView: GIFImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.animate(withGIFNamed: "giftrd") {
            print("It's animating!")
        }
    }

    @IBAction func confirmTapped(_ sender: UIButton) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}
