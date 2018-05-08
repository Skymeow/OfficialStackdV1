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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var archiveBtn: UIButton!
    @IBOutlet weak var CenterX: NSLayoutConstraint!
    @IBOutlet weak var backFromPopupView: UIView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceHostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
        successView.configureView(title: "Saved to Stacked", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
    }
    
    func configureDeletedModal() {
        guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var genericCell: UITableViewCell?
        let item = self.items![indexPath.row]
        let type = item.cellType!
        //        item.rearrangedRow = Int64(indexPath.row)
        //        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
        switch type {
        case "podcast":
            if let cell = tableView.dequeueReusableCell(withIdentifier: "regularcell", for: indexPath) as? SharedTableViewCell {
                genericCell = cell
                cell.duration.text = item.duration
                cell.sourceLabel.text = "apple.itunes.com"
                let img = UIImage(named: "listen_small")
                cell.sourceLogo.image = img
                cell.sourceTitle.text = item.title
                
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
            PrepareForPresentingViews.shared.redirectToPodcast(url!)
        case "youtube":
            PrepareForPresentingViews.shared.openInApp(url!, viewController: self, navigationController: self.navigationController)
        case "safari":
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
