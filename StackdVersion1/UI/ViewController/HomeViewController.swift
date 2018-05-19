//
//  HomeViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/18/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    var isFilterTagged = false
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationController?.navigationBar.isHidden = true
        let frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        headerView.addSubview(customizedHeaderView)
        customizedHeaderView.customedHeaderDelegate = self 
    }

}
extension HomeViewController: HeaderActionDelegate {
    func filterTapped() {
        if self.isFilterTagged == false {
            self.filterContainerView.isHidden = false
            self.homeContainerView.isHidden = true
            self.isFilterTagged = true
        } else {
            self.filterContainerView.isHidden = true
            self.homeContainerView.isHidden = false
            self.isFilterTagged = false
        }
        
    }
}
