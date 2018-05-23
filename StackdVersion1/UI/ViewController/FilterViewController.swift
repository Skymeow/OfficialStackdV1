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
    
    var podcasts = [Podcast]()
    var safaris = [Safari]()
    var youtubes = [Youtube]()
    let categories = ["Articles", "Videos", "Podcasts"]
    let categoryButtons = [#imageLiteral(resourceName: "read_tapped"), #imageLiteral(resourceName: "watch_tapped"), #imageLiteral(resourceName: "listen_tapped")]
    let greyCategoryButtons = [#imageLiteral(resourceName: "read_default"), #imageLiteral(resourceName: "watch_default"), #imageLiteral(resourceName: "listen_default")]
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = HomeViewController()
     
        articleButton.setBackgroundImage(greyCategoryButtons[0], for: .normal)
        videoButton.setBackgroundImage(greyCategoryButtons[1], for: .normal)
        podcastButton.setBackgroundImage(greyCategoryButtons[2], for: .normal)
        articleButton.addTarget(self, action: #selector(articleTapped), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(videoTapped), for: .touchUpInside)
        podcastButton.addTarget(self, action: #selector(podcastTapped), for: .touchUpInside)
        
        let podcastNum = self.podcasts.count ?? 0
        let safarisNum = self.safaris.count ?? 0
        let youtubesNum = self.youtubes.count ?? 0
        self.articleLabel.text = "\(safarisNum) Articles"
        self.videoLabel.text = "\(youtubesNum) Videos"
        self.podcastLabel.text = "\(podcastNum) Podcasts"
        self.articleLabel.textColor = UIColor.gray
        self.videoLabel.textColor = UIColor.gray
        self.podcastLabel.textColor = UIColor.gray
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

extension FilterViewController: HomeDelegate {
    func passItems(podcasts: [Podcast]?, safaris: [Safari]?, youtubes: [Youtube]?) {
        if let podcast = podcasts {
            self.podcasts = podcast
        }
        if let safari = safaris {
            self.safaris = safari
        }
        if let youtube = youtubes {
            self.youtubes = youtube
        }
    }
}
