//
//  FilteredItemsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class FilteredItemsViewController: UIViewController {

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

extension FilteredItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.sharedItems {
            return items.count
        } else {
            //            FIXME: change it into 0 
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilteredItemCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        
        return customizedHeaderView
    }
}
