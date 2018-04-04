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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var articleButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBOutlet weak var podcastButton: UIButton!
    var podcasts = [Podcast]()
    var safaris = [Safari]()
    var youtubes = [Youtube]()
    let categories = ["Articles", "Videos", "Podcasts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        headerView.addSubview(customizedHeaderView)
        articleButton.addTarget(self, action: #selector(articleTapped), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(videoTapped), for: .touchUpInside)
        podcastButton.addTarget(self, action: #selector(podcastTapped), for: .touchUpInside)
    }
    
    @objc func articleTapped() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.sharedItems = TabelViewCellItemType(type: "safari", item: self.safaris)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func videoTapped() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.sharedItems = TabelViewCellItemType(type: "youtube", item: self.youtubes)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func podcastTapped() {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        vc.sharedItems = TabelViewCellItemType(type: "podcast", item: self.podcasts)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
