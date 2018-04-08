//
//  ArchiveViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/8/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import CoreData

class ArchiveViewController: UIViewController {
    
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
        
//        fetch all archived Items
        self.podcasts = fetchAllArchived(Podcast.self, route: .podcast)
        self.safaris = fetchAllArchived(Safari.self, route: .safari)
        self.youtubes = fetchAllArchived(Youtube.self, route: .youtube)
        
        let sharedItems1 = TabelViewCellItemType(type: "podcast", item: self.podcasts)
        let sharedItems2 = TabelViewCellItemType(type: "safari", item: self.safaris)
        let sharedItems3 = TabelViewCellItemType(type: "youtube", item: self.youtubes)
        self.sharedItems = [sharedItems1, sharedItems2, sharedItems3]
    }
    
}

extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.sharedItems {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let type = self.sharedItems![indexPath.row].type
        print(type)
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
            }
        case "safari":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
            }
        case "youtube":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as? YoutubeTableViewCell {
                genericCell = cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
            }
        }
        
        return genericCell!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        customizedHeaderView.customedHeaderDelegate = self
        
        return customizedHeaderView
    }
}

extension ArchiveViewController: HeaderActionDelegate {
    func filterTapped() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filterVC") as! FilterViewController
        vc.podcasts = self.podcasts
        vc.youtubes = self.youtubes
        vc.safaris = self.safaris
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
