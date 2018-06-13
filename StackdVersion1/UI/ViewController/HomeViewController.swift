//
//  HomeViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/18/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import CoreData
import Gifu
import SnapKit

protocol HomeDelegate: class {
    func notifyEdit()
    func cancelEdit()
}

class HomeViewController: UIViewController {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
    var isFilterTagged = false
    var isSetEdit = true
    var placeHolderView: ShowIfEmptyView?
    var openView: OpenAppView?
    var seenIntro = false
    weak var delegate: HomeDelegate?
    var customizedHeaderView: CustomHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         NotificationCenter.default.addObserver(self, selector: #selector(dismissIntro(notification:)), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        let all = fetchAll(AllItem.self, route: .allItemUnArchived)
        if all.count == 0 {
            self.placeHolderView = ShowIfEmptyView(frame: (self.tabBarController?.view.frame)!)
            self.tabBarController?.view.addSubview(placeHolderView!)
        }
        UserDefaults.standard.set(true, forKey: "saw_onboarding")
        self.navigationController?.navigationBar.isHidden = true
        let frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 150)
        self.customizedHeaderView = CustomHeaderView(frame: frame)
        headerView.addSubview(customizedHeaderView!)
        customizedHeaderView?.customedHeaderDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showWhenOpenApp()
    }
    
    func showWhenOpenApp() {
        self.openView = OpenAppView(frame: (self.tabBarController?.view.frame)!)
        self.tabBarController?.view.addSubview(self.openView!)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.openView?.removeFromSuperview()
        })
    }
    
    @objc func dismissIntro(notification: NSNotification) {
        let all = fetchAll(AllItem.self, route: .allItemUnArchived)
        if all.count != 0 {
            self.placeHolderView?.removeFromSuperview()
        }
    }
    
    func loadDifferentTypeItems() {
        let podcasts = fetchAll(Podcast.self, route: .podcast)
        let safaris = fetchAll(Safari.self, route: .safari)
        let youtubes = fetchAll(Youtube.self, route: .youtube)
        let youtubeNotiDict: [String: [Youtube]] = ["youtubes": youtubes]
        NotificationCenter.default.post(name: .youtubes, object: nil, userInfo: youtubeNotiDict)
        let safarisNotiDict: [String: [Safari]] = ["safaris": safaris]
        NotificationCenter.default.post(name: .safaris, object: nil, userInfo: safarisNotiDict)
        let podcastNotiDict: [String: [Podcast]] = ["podcasts": podcasts]
        NotificationCenter.default.post(name: .podcasts, object: nil, userInfo: podcastNotiDict)
    }

}
extension HomeViewController: HeaderActionDelegate {
    func shareTapped() {
        if self.isSetEdit == false {
            self.delegate?.notifyEdit()
            self.isSetEdit = true
            self.customizedHeaderView?.subTitleLabel.text = "Cancel"
        } else {
            self.delegate?.cancelEdit()
            self.customizedHeaderView?.subTitleLabel.text = "Share Items"
            self.isSetEdit = false
        }
    }
    
    func filterTapped() {
        self.loadDifferentTypeItems()
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


