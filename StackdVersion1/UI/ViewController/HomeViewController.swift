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

class HomeViewController: UIViewController {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
    var isFilterTagged = false
    var placeHolderView: ShowIfEmptyView?
    var seenIntro = false
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
        let customizedHeaderView = CustomHeaderView(frame: frame)
        headerView.addSubview(customizedHeaderView)
        customizedHeaderView.customedHeaderDelegate = self 
    }
    
    @objc func dismissIntro(notification: NSNotification) {
        let all = fetchAll(AllItem.self, route: .allItemUnArchived)
        if all.count != 0 {
            self.placeHolderView?.removeFromSuperview()
        }
    }
    
//    deinit observe
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//    }
    
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
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }

    
}
extension HomeViewController: HeaderActionDelegate {
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


