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
    var podcasts = [Podcast]()
    var safaris = [Safari]()
    var youtubes = [Youtube]()
    @IBOutlet weak var tableView: UITableView!
    let categories = ["Articles", "Videos", "Podcasts"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "toVideos":
                let vc = segue.destination as! FilteredItemsViewController
                let items = TabelViewCellItemType(type: "youtube", item: self.youtubes)
                vc.sharedItems = items
            case "toPodcasts":
                let vc = segue.destination as! FilteredItemsViewController
                let items = TabelViewCellItemType(type: "podcast", item: self.podcasts)
                vc.sharedItems = items
            case "toArticles":
                let vc = segue.destination as! FilteredItemsViewController
                let items = TabelViewCellItemType(type: "safari", item: self.safaris)
                vc.sharedItems = items
            default:
                "print no segue selected"
            }
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: FilterParamCell!
        switch indexPath.row {
        case 0:
        cell = tableView.dequeueReusableCell(withIdentifier: "articlecell", for: indexPath) as! FilterParamCell
        case 1:
        cell = tableView.dequeueReusableCell(withIdentifier: "podcastcell", for: indexPath) as! FilterParamCell
        case 2:
        cell = tableView.dequeueReusableCell(withIdentifier: "videocell", for: indexPath) as! FilterParamCell
        default:
            print("default cell")
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat((tableView.contentSize.width + 80) / 3)
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.categories[indexPath.row]
        print(row)
        switch row {
        case "Articles":
            self.performSegue(withIdentifier: "toArticles", sender: self)
        case "Videos":
            self.performSegue(withIdentifier: "toVideos", sender: self)
        case "Podcasts":
            self.performSegue(withIdentifier: "toPodcasts", sender: self)
        default:
            print("no cell tapped")
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        
        return customizedHeaderView
    }
}

//extension FilterViewController: FilterVCDelegate {
//    func passCategory(sender: FilterParamCell) {
//        let index = self.tableView.indexPath(for: sender)
//        let category = self.categories[(index?.row)!]
//        let sb = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}

