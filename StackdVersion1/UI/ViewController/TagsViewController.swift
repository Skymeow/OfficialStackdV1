//
//  TagsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/8/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class TagsViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backTapped(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var tagTextField: UITextField!
    
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagTextField.resignFirstResponder()
        if tagTextField.text?.isEmpty == false {
            
        } else {
            
        }
        
        return true
    }
}
