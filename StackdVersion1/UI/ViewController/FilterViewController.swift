//
//  FilterViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var podcastButton: UIButton!
    
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var videoLabel: UILabel!
    @IBOutlet weak var podcastLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var podcasts: [Podcast]?
    var safaris: [Safari]?
    var youtubes: [Youtube]?
    let categories = ["Articles", "Videos", "Podcasts"]
    let categoryButtons = [#imageLiteral(resourceName: "read_tapped"), #imageLiteral(resourceName: "watch_tapped"), #imageLiteral(resourceName: "listen_tapped")]
    let greyCategoryButtons = [#imageLiteral(resourceName: "read_default"), #imageLiteral(resourceName: "watch_default"), #imageLiteral(resourceName: "listen_default")]
    var podcastNum: Int?
    var youtubeNum: Int?
    var safarisNum: Int?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(observePodcastChange(notification:)), name: .podcasts, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(observeYoutubeChange(notification:)), name: .youtubes, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(observeSafarisChange(notification:)), name: .safaris, object: nil)
        
        articleButton.setBackgroundImage(greyCategoryButtons[0], for: .normal)
        videoButton.setBackgroundImage(greyCategoryButtons[1], for: .normal)
        podcastButton.setBackgroundImage(greyCategoryButtons[2], for: .normal)
        articleButton.addTarget(self, action: #selector(articleTapped), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(videoTapped), for: .touchUpInside)
        podcastButton.addTarget(self, action: #selector(podcastTapped), for: .touchUpInside)
        
        self.articleLabel.textColor = UIColor.gray
        self.videoLabel.textColor = UIColor.gray
        self.podcastLabel.textColor = UIColor.gray
    }
    
    @objc func observePodcastChange(notification: NSNotification) {
        if let podcasts = notification.userInfo?["podcasts"] as? [Podcast] {
            self.podcasts = podcasts
            podcastNum = self.podcasts?.count ?? 0
            self.podcastLabel.text = "\(podcastNum!) Podcasts"
        }
    }
    
    @objc func observeYoutubeChange(notification: NSNotification) {
        if let youtubes = notification.userInfo?["youtubes"] as? [Youtube] {
            self.youtubes = youtubes
            youtubeNum = self.youtubes?.count ?? 0
            self.videoLabel.text = "\(String(describing: youtubeNum!)) Videos"
        }
    }
    
    @objc func observeSafarisChange(notification: NSNotification) {
        if let safaris = notification.userInfo?["safaris"] as? [Safari] {
            self.safaris = safaris
            safarisNum = self.safaris?.count ?? 0
            self.articleLabel.text = "\(String(describing: safarisNum!)) Articles"
        }
    }
    
    @objc func articleTapped() {
        articleButton.setBackgroundImage(categoryButtons[0], for: .normal)
        self.articleLabel.textColor = UIColor.init(rgb: 0x308E8D)
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.items = self.safaris
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func videoTapped() {
        videoButton.setBackgroundImage(categoryButtons[1], for: .normal)
        self.videoLabel.textColor = UIColor.init(rgb: 0x308E8D)
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.items = self.youtubes
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func podcastTapped() {
        podcastButton.setBackgroundImage(categoryButtons[2], for: .normal)
        self.podcastLabel.textColor = UIColor.init(rgb: 0x308E8D)
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.items = self.podcasts
        self.navigationController?.pushViewController(vc, animated: false)
    }
}


