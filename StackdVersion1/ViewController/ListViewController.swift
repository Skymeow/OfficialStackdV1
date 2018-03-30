//
//  ViewController.swift
//  StackedV1
//
//  Created by Sky Xu on 3/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import CoreData

class ListViewController: UIViewController {
    
    
    var sharedItems: [Any]? {
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
        self.tableView.sectionHeaderHeight = 230
        
        //  FIXME: time analyse for web url currently not working
        let webUrlStr = "https://medium.com/@ziadtamim/create-parallax-effect-with-uimotioneffect-3a3ae7aa1679"
        Networking.instance.analyzeTime(url: webUrlStr) { (success, timeStr) in
            if success {
                print(timeStr)
            }
        }
//        let youtubeStr = "https://www.youtube.com/watch?v=Y7ojcTR78qE&spfreload=9"
//        Networking.instance.getYoutubeDetail(youtubeUrl: youtubeStr) { (success, result) in
//            if success {
//                print(result)
//            }
//        }
//       let time =  PodcastDataServer.instance.getPodcastInfo("https://itunes.apple.com/us/podcast/running-into-problems-shared-cross-platform-code-in/id1231805301?i=1000406940185&mt=2")
        self.podcasts = fetchAll(Podcast.self, route: .podcast)
        self.safaris = fetchAll(Safari.self, route: .safari)
        self.youtubes = fetchAll(Youtube.self, route: .youtube)
        self.sharedItems?.append(self.safaris)
        self.sharedItems?.append(self.podcasts)
        self.sharedItems?.append(self.youtubes)
    }
  
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.sharedItems {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SharedTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 230)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        
        return customizedHeaderView
    }
    
    
}

