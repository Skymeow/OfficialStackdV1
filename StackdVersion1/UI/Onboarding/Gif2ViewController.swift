//
//  Gif2ViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import Gifu

class Gif2ViewController: UIViewController {
    @IBOutlet weak var gifView: GIFImageView!
    
    @IBAction func skipTapped(_ sender: UIButton) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gifView.animate(withGIFNamed: "gifsec") {
            print("It's animating!")
        }
    }

  

}
