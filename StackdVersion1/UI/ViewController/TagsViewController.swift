//
//  TagsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/8/18.
//  Copyright

import UIKit
import CoreData

class TagsViewController: UIViewController, UITextFieldDelegate {
    
    var initialIndexPath: IndexPath? = nil
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
    
//    CHANGED INTO SAVE TAPPED
    @IBAction func cancelTapped(_ sender: UIButton) {
        if tagTextField.text?.isEmpty == false {
            let tag = tagTextField.text
            let coredataTag = Tags(context: coreDataStack.privateContext)
            coredataTag.content = tag
            coredataTag.itemId = selected?.id
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            self.configureTagedModal()
        } else {
            //            show alert view that the tag field is empty
            AlertView.instance.presentAlertView("Please enter a valid tag keyword", self)
        }
        self.navigationController?.popViewController(animated: false)
    }
    
    func configureTagedModal() {
        guard let successView = Bundle.main.loadNibNamed("FadingAlertView", owner: self, options: nil)![0] as? FadingAlertView else { return }
        successView.configureView(title: "Taged", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagTextField.resignFirstResponder()
        if tagTextField.text?.isEmpty == false {
            let tag = tagTextField.text
            let coredataTag = Tags(context: coreDataStack.privateContext)
            coredataTag.content = tag
            coredataTag.itemId = selected?.id
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            self.configureTagedModal()
        } else {
//            show alert view that the tag field is empty
            AlertView.instance.presentAlertView("Please enter a valid tag keyword", self)
        }
        self.navigationController?.popViewController(animated: false)
        self.view.endEditing(true)
        return true
    }
}
