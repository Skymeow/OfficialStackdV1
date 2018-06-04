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
import Kingfisher

class ArchiveViewController: UIViewController, OpenedViewDelegate {
    func changeXis() {
        
    }
    
    let coreDataStack = CoreDataStack.instance
    var tagIndex: IndexPath?
    var items: [AllItem]?{
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var selectedIndex: IndexPath?
    var selected: AllItem!
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
//        navigationBar.isHidden = true
        self.tableView.sectionHeaderHeight = 150
        
        let nibCell = UINib(nibName: "SharedTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: "regularcell")
        
        let nibCell2 = UINib(nibName: "YoutubeTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell2, forCellReuseIdentifier: "youtubecell")
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for:  .valueChanged)
        
        self.loadItems()
    }
    
    func loadTags() {
        if let reloadCell = self.tagIndex {
            tableView.reloadRows(at: [reloadCell], with: .none)
        }
    }
    
    func loadItems() {
        //        fetch all archived Items
        self.items = fetchAll(AllItem.self, route: .allItemArchived)
    }
    
    @objc func refreshData(_ sender: Any) {
        self.loadItems()
        self.loadTags()
        self.refreshControl.endRefreshing()
    }
    
}

extension ArchiveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowHeight = CGFloat(120)
        
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = ArchiveHeaderView(frame: frame)
        
        return customizedHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let item = self.items![indexPath.row]
        let type = self.items![indexPath.row].cellType!
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "itunes"
                let img = UIImage(named: "listen_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                cell.createdAt.text = item.date?.toString()
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
                }
            }
        case "safari":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                let duration = item.duration?.formatDurationForArticle()
                cell.duration.text = duration
                cell.sourceLabel.text = item.urlStr?.formatSafariUrl()
                let img = UIImage(named: "read_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                cell.createdAt.text = item.date?.toString()
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
                }
            }
        case "youtube":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as? YoutubeTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "youtube"
                cell.sourceImg.kf.indicatorType = .activity
                let url = URL(string: item.videoThumbnail!)
                cell.sourceImg.kf.setImage(with: url, options: [.cacheSerializer(FormatIndicatedCacheSerializer.jpeg), .cacheSerializer(FormatIndicatedCacheSerializer.png)])
                let img = UIImage(named: "watch_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                cell.createdDate.text = item.date?.toString()
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
                }
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
            }
        }
        
        return genericCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = self.items![indexPath.row]
        let url = selected.urlStr!
        let selectedType = selected.cellType!
        self.selectedIndex = indexPath
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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tagAction = self.toogleTag(forRowAtIndexPath: indexPath)
        let deleteAction = self.toogleDelete(forRowAtIndexPath: indexPath)
        let topAction = self.toogleTop(forRowAtIndexPath: indexPath)
        let bottomAction = self.toogleBottom(forRowAtIndexPath: indexPath)
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction, tagAction, bottomAction, topAction])
        swipeConfig.performsFirstActionWithFullSwipe = false
        return swipeConfig
    }
    
    func toogleTag(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Tag") { (action, view, completionHandler: (Bool) -> Void) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let tagVC = storyboard.instantiateViewController(withIdentifier: "tagVC") as! TagsViewController
            tagVC.delegate = self
            tagVC.selected = self.items?[indexPath.row]
            self.navigationController?.pushViewController(tagVC, animated: false)
            self.tagIndex = indexPath
            completionHandler(true)
        }
        
        action.image = #imageLiteral(resourceName: "tag")
        action.backgroundColor = .lightGray
        return action
    }
    
    func toogleDelete(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] (action, view, completionHandler: (Bool) -> Void) in
            let removeItem = self.items![indexPath.row]
            self.items?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.coreDataStack.privateContext.delete(removeItem)
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            
            completionHandler(true)
        }
        action.image = #imageLiteral(resourceName: "popup_delete")
        action.backgroundColor = .lightGray
        return action
    }
    
    func toogleTop(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Top") { [unowned self] (action, view, completionHandler: (Bool) -> Void) in
            let movedObject = self.items![indexPath.row]
            let beMovedObject = self.items![0]
            self.items?.remove(at: indexPath.row)
            self.items?.insert(movedObject, at: 0)
            movedObject.rearrangedRow = Int64(0)
            beMovedObject.rearrangedRow = Int64(indexPath.row)
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            
            completionHandler(true)
        }
        
        action.image = #imageLiteral(resourceName: "top")
        action.backgroundColor = .lightGray
        return action
    }
    
    func toogleBottom(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Bottom") { [unowned self] (action, view, completionHandler: (Bool) -> Void) in
            let movedObject = self.items![indexPath.row]
            let bottomIndex = (self.items?.count)! - 1
            let beMovedObject = self.items![bottomIndex]
            self.items?.remove(at: indexPath.row)
            self.items?.insert(movedObject, at: bottomIndex)
            movedObject.rearrangedRow = Int64(bottomIndex)
            beMovedObject.rearrangedRow = Int64(indexPath.row)
            self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            
            completionHandler(true)
        }
        action.image = #imageLiteral(resourceName: "bottom")
        action.backgroundColor = .lightGray
        return action
    }
}

extension ArchiveViewController: TagsDelegate {
    func reloadTags() {
        self.loadTags()
        
    }
}

