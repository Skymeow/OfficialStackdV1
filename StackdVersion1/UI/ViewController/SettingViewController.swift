//
//  SettingViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/20/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        self.sendEmail()
    }

}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["jsbotto@gmail.com"])
            mail.setMessageBody("<p>let us know how we can do better</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            AlertView.instance.presentAlertView("Please enable send email in setting", self)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
