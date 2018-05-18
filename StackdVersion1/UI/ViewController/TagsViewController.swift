//
//  TagsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/8/18.
//  Copyright

import UIKit
import CoreData

class TagsViewController: UIViewController, UITextFieldDelegate {
    
    let coreDataStack = CoreDataStack.instance
    var selected: AllItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        tagTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBOutlet weak var tagTextField: UITextField!
    
    
    @IBAction func cancelTapped(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
         self.navigationController?.popViewController(animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagTextField.resignFirstResponder()
        if tagTextField.text?.isEmpty == false {
            let tag = tagTextField.text
            self.selected?.setValue(tag, forKey: "tag")
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
        } else {
//            show alert view that the tag field is empty
            AlertView.instance.presentAlertView("Please enter a valid tag keyword", self)
        }
        self.navigationController?.popViewController(animated: false)
        self.view.endEditing(true)
        return true
    }
}
