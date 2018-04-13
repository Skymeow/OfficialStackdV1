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
import Kingfisher

class HomeListViewController: UIViewController, OpenedViewDelegate {
   
    var selected: AllItem!
    var podcasts = [Podcast]()
    var safaris = [Safari]()
    var youtubes = [Youtube]()
    var allItems: [AllItem]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        self.allItems = fetchAll(AllItem.self, route: .allItem)
    }
    
    func changeXis() {
        print("")
    }
}

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.allItems {
            print(items.count)
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowHeight = CGFloat(120)
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let item = self.allItems![indexPath.row]
        let type = item.cellType!
        print(type)
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "apple.itunes.com"
                let img = UIImage(named: "listen_tapped")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                
            }
        case "safari":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                let duration = item.duration?.formatDurationForArticle()
                cell.duration.text = duration
                cell.sourceLabel.text = item.urlStr?.getSafariSource()
                let img = UIImage(named: "read_default")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
            }
        case "youtube":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as? YoutubeTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "www.youtube.com"
                cell.sourceImg.kf.indicatorType = .activity
                let url = URL(string: item.videoThumbnail!)
                cell.sourceImg.kf.setImage(with: url, options: [.cacheSerializer(FormatIndicatedCacheSerializer.jpeg), .cacheSerializer(FormatIndicatedCacheSerializer.png)])
                let img = UIImage(named: "watch_default")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
               genericCell = cell
            }
        }
       
        return genericCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = self.allItems![indexPath.row]
        let url = selected.urlStr!
        let selectedType = selected.cellType!
        switch selectedType {
        case "podcast":
            PrepareForPresentingViews.shared.redirectToPodcast(url)
        case "youtube":
            PrepareForPresentingViews.shared.openInApp(url, viewController: self, navigationController: self.navigationController)
        case "safari":
            PrepareForPresentingViews.shared.openInApp(url, viewController: self, navigationController: self.navigationController)
        default:
            print("exception in didselect")
        }
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
        vc.podcasts = self.podcasts
        vc.youtubes = self.youtubes
        vc.safaris = self.safaris
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
