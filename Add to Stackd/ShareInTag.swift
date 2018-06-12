//
//  ShareInTag.swift
//  Add to Stackd
//
//  Created by Sky Xu on 6/9/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import IHKeyboardAvoiding

protocol ShareTageDelegate: class {
    func notifyShareVC()
}
class ShareInTag: UIView, UITextFieldDelegate {
   
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var saveTagBtn: UIButton!
    var alertView: FadingAlertView!
    let coreDataStack = CoreDataStack.instance
    var itemId: String?
    weak var delegate: ShareTageDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       
        KeyboardAvoiding.avoidingView = self
        text.clearButtonMode = UITextFieldViewMode.whileEditing
        self.saveTagBtn.addTarget(self, action: #selector(saveTag), for: .touchUpInside)
    }
    
    @objc func saveTag() {
        if text.text?.isEmpty == false {
            let tag = text.text
            self.tagLabel.text = tag
            let coredataTag = Tags(context: coreDataStack.privateContext)
            coredataTag.content = tag
            guard let id = self.itemId else { return }
            coredataTag.itemId = id
            coreDataStack.saveTo(context: coreDataStack.privateContext)
        }
//        Notify shareextension to show stackd view
        self.dismiss()
        delegate?.notifyShareVC()
    }
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.dismiss()
    }
  
    func dismiss() {
        self.removeFromSuperview()
    }
}

