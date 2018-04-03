//
//  HomeListViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import CoreData

class HomeListViewController: UIViewController {

    var sharedItems: [TabelViewCellItemType]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var podcasts = [Podcast]()
    var safaris = [Safari]()
    var youtubes = [Youtube]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.sectionHeaderHeight = 150
        
        let nibCell = UINib(nibName: "SharedTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: "regularcell")
        
        let nibCell2 = UINib(nibName: "YoutubeTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell2, forCellReuseIdentifier: "youtubecell")
        
        self.podcasts = fetchAll(Podcast.self, route: .podcast)
        self.safaris = fetchAll(Safari.self, route: .safari)
        self.youtubes = fetchAll(Youtube.self, route: .youtube)
        
        let sharedItems1 = TabelViewCellItemType(type: "podcast", item: self.podcasts)
        let sharedItems2 = TabelViewCellItemType(type: "safari", item: self.safaris)
        let sharedItems3 = TabelViewCellItemType(type: "youtube", item: self.youtubes)
        self.sharedItems = [sharedItems1, sharedItems2, sharedItems3]
    }
    
}

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.sharedItems {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.sharedItems![indexPath.row].type
        print(type)
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                
                return cell
            }
        case "safari":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                
                return cell
            }
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as? YoutubeTableViewCell {
                
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SharedTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        customizedHeaderView.customedHeaderDelegate = self
        
        return customizedHeaderView
    }
}

extension HomeListViewController: HeaderActionDelegate {
    func filterTapped() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
