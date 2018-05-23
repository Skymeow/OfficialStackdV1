//
//  HomeViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/18/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import CoreData

protocol HomeDelegate: class {
    func passItems(podcasts: [Podcast]?, safaris: [Safari]?, youtubes: [Youtube]?)
}
class HomeViewController: UIViewController {

    @IBOutlet weak var filterContainerView: UIView!
    @IBOutlet weak var homeContainerView: UIView!
    @IBOutlet weak var headerView: UIView!
//    var podcasts = [Podcast]()
//    var safaris = [Safari]()
//    var youtubes = [Youtube]()
    var isFilterTagged = false
    weak var delegate: HomeDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var delegate: HomeDelegate?
        self.navigationController?.navigationBar.isHidden = true
        let frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        headerView.addSubview(customizedHeaderView)
        customizedHeaderView.customedHeaderDelegate = self 
    }
    
    func loadDifferentTypeItems(completion: @escaping (Bool, [Podcast]?, [Safari]?, [Youtube]?) -> ()) {
        let podcasts = fetchAll(Podcast.self, route: .podcast)
        let safaris = fetchAll(Safari.self, route: .safari)
        let youtubes = fetchAll(Youtube.self, route: .youtube)
        print(youtubes.count)
        completion(true, podcasts, safaris, youtubes)
    }
    
    

}
extension HomeViewController: HeaderActionDelegate {
    func filterTapped() {
        self.loadDifferentTypeItems { (success, podcasts, safaris, youtubes) in
            if success {
                self.delegate?.passItems(podcasts: podcasts, safaris: safaris, youtubes: youtubes)
            }
        }
       
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


