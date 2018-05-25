//
//  FilteredItemsViewController.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class FilteredItemsViewController: UIViewController, OpenedViewDelegate {
    
    var selectedIndex: IndexPath?
    let coreDataStack = CoreDataStack.instance
    var items: [AllItem]?
    var selected: AllItem?
    var initialIndexPath: IndexPath? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var archiveBtn: UIButton!
    @IBOutlet weak var CenterX: NSLayoutConstraint!
    @IBOutlet weak var backFromPopupView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceHostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
        self.tableView.dragInteractionEnabled = true
        
        CenterX.constant = 1000
        self.tableView.sectionHeaderHeight = 150
        
        let nibCell = UINib(nibName: "SharedTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell, forCellReuseIdentifier: "regularcell")
        
        let nibCell2 = UINib(nibName: "YoutubeTableViewCell", bundle: Bundle.main)
        tableView.register(nibCell2, forCellReuseIdentifier: "youtubecell")
        
        backFromPopupView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissXis)))
        deleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        archiveBtn.addTarget(self, action: #selector(archiveTapped), for: .touchUpInside)
    }
    
    func changeXis() {
        self.CenterX.constant = 0
    }
    
    @objc func dismissXis() {
        self.CenterX.constant = 1000
    }
    
    func openInApp(_ urlStr: String) {
        let vc = WebViewController()
        vc.openedViewdelegate = self
        vc.urlStr = urlStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func redirectToPodcast(_ urlStr: String) {
        let url = URL(string: urlStr)!
        UIApplication.shared.open(url, options: [:]) { (success) in
            if success {
                print("podcast opened")
            }
        }
    }
    
//    for drag and drop
    @objc func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        //        this is the indexpath of the start of drag
        var indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state{
        case UIGestureRecognizerState.began:
            if indexPath != nil {
                self.initialIndexPath = indexPath
                
            }
        case UIGestureRecognizerState.changed:
            break
        case .ended:
            if ((indexPath != nil) && (indexPath != self.initialIndexPath)) {
                //                print(indexPath!, initialIndexPath!)
                let movedObject = self.items![initialIndexPath!.row]
                let beMovedObject = self.items![indexPath!.row]
                self.items?.remove(at: initialIndexPath!.row)
                self.items?.insert(movedObject, at: indexPath!.row)
                movedObject.rearrangedRow = Int64(indexPath!.row)
                beMovedObject.rearrangedRow = Int64(indexPath!.row)
                self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
            }
        case .cancelled:
            break
        case .failed:
            break
        case .possible:
            break
        }
        
    }
    
//    delete from coredata
    @objc func deleteTapped() {
        CenterX.constant = 1000
        if let index = self.selectedIndex {
            self.items?.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .automatic)
        }
        
        self.coreDataStack.privateContext.delete(self.selected!)
        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
        configureDeletedModal()
    }
    
//    set selected item's coredata archive to be true
    @objc func archiveTapped() {
        CenterX.constant = 1000
        if let index = self.selectedIndex {
            self.items?.remove(at: index.row)
            tableView.deleteRows(at: [index], with: .automatic)
        }
        self.selected?.setValue(true, forKey: "archived")
        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
        self.configureArchivedModal()
    }
    
    func configureArchivedModal() {
        guard let successView = Bundle.main.loadNibNamed("FadingAlertView", owner: self, options: nil)![0] as? FadingAlertView else { return }
        successView.configureView(title: "Archived", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
    }
    
    func configureDeletedModal() {
        guard let successView = Bundle.main.loadNibNamed("FadingAlertView", owner: self, options: nil)![0] as? FadingAlertView else { return }
        successView.configureView(title: "Deleted", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
    }
}

extension FilteredItemsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = self.items {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowHeight = CGFloat(120)
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let item = self.items![indexPath.row]
        let type = item.cellType ?? "podcast"
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "apple.itunes.com"
                let img = UIImage(named: "listen_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
//                    if tags.count != 0 {
//                        print("tags babe", tags[0].content!)
//                    }
                }
            }
        case "safari":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                let duration = item.duration?.formatDurationForArticle()
                cell.duration.text = duration
                cell.sourceLabel.text = item.urlStr?.getSafariSource()
                let img = UIImage(named: "read_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
//                    if tags.count != 0 {
//                        print("tags babe", tags[0].content!)
//                    }
                }
            }
        case "youtube":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "youtubecell", for: indexPath) as? YoutubeTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "www.youtube.com"
                cell.sourceImg.kf.indicatorType = .activity
                let url = URL(string: item.videoThumbnail!)
                cell.sourceImg.kf.setImage(with: url, options: [.cacheSerializer(FormatIndicatedCacheSerializer.jpeg), .cacheSerializer(FormatIndicatedCacheSerializer.png)])
                let img = UIImage(named: "watch_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                if let id = item.id {
                    let tags = fetchAll(Tags.self, route: .tags(itemId: id))
                    cell.tagsData = tags
//                    if tags.count != 0 {
//                        print("tags babe", tags[0].content!)
//                    }
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
        self.selectedIndex = indexPath
        let url = selected?.urlStr!
        let selectedType = (selected?.cellType)!
        switch selectedType {
        case "podcast":
            self.sourceHostLabel.text = selected?.urlStr?.getSafariSource()
            self.sourceLabel.text = selected?.title
            PrepareForPresentingViews.shared.redirectToPodcast(url!)
        case "youtube":
            self.sourceHostLabel.text = selected?.urlStr?.getSafariSource()
            self.sourceLabel.text = selected?.title
            PrepareForPresentingViews.shared.openInApp(url!, viewController: self, navigationController: self.navigationController)
        case "safari":
            self.sourceHostLabel.text = selected?.urlStr?.getSafariSource()
            self.sourceLabel.text = selected?.title
            PrepareForPresentingViews.shared.openInApp(url!, viewController: self, navigationController: self.navigationController)
        default:
            print("exception in didselect")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let filterHeaderView = FilterHeaderView(frame: frame)
        filterHeaderView.filterHeaderDelegate = self
        return filterHeaderView
    }

}

//for the back button
extension FilteredItemsViewController: FilterHeaderActionDelegate {
    func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}


