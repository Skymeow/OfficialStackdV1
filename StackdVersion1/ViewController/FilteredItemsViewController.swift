//
//  FilteredItemsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import CoreData

class FilteredItemsViewController: UIViewController, OpenedViewDelegate {
    
    var sharedItems: TabelViewCellItemType?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var archiveBtn: UIButton!
    @IBOutlet weak var CenterX: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        CenterX.constant = -400
        self.tableView.sectionHeaderHeight = 150
        
        let nibCell = UINib(nibName: "SharedTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: "regularcell")
        
        let nibCell2 = UINib(nibName: "YoutubeTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell2, forCellReuseIdentifier: "youtubecell")
        
        deleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        archiveBtn.addTarget(self, action: #selector(archiveTapped), for: .touchUpInside)
    }
    
    func changeXis() {
        self.CenterX.constant = 0
    }
    
    func openInApp() {
        let vc = WebViewController()
        vc.openedViewdelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func redirectToPodcast() {
        let url = URL(string: "https://itunes.apple.com/us/podcast/sleep-and-relax-asmr/id1133320064?mt=2&i=10003989096")!
        UIApplication.shared.open(url, options: [:]) { (success) in
            if success {
                print("podcast opened")
            }
        }
    }
//    delete from coredata
    @objc func deleteTapped() {
        
    }
//    save to coredata archive
    @objc func archiveTapped() {
        
    }
}

extension FilteredItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.sharedItems?.item {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let type = self.sharedItems!.type
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
        
        return customizedHeaderView
    }
}
