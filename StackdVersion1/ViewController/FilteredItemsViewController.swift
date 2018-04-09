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
    
    let coreDataStack = CoreDataStack.instance
    var sharedItems: TabelViewCellItemType?
    var selected: NSManagedObject!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var archiveBtn: UIButton!
    @IBOutlet weak var CenterX: NSLayoutConstraint!
    @IBOutlet weak var backFromPopupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CenterX.constant = -400
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
        self.CenterX.constant = -400
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
        CenterX.constant = -400
        if let allObjects = self.sharedItems?.item {
            for object in allObjects {
                self.coreDataStack.viewContext.delete(object)
            }
        }
    }
    
//    set selected item's coredata archive to be true
    @objc func archiveTapped() {
        CenterX.constant = -400
        self.selected.setValue(true, forKey: "archived")
        self.coreDataStack.saveTo(context: self.coreDataStack.viewContext)
        self.configureArchivedModal()
    }
    
    func configureArchivedModal() {
        guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
        successView.configureView(title: "Saved to Stacked", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = self.sharedItems!.item[indexPath.row]
        let url = selected.value(forKeyPath: "urlStr") as! String
        let selectedType = self.sharedItems!.type
        switch selectedType {
        case "podcast":
            self.redirectToPodcast(url)
        case "youtube":
            self.openInApp(url)
        case "safari":
            self.openInApp(url)
        default:
            print("exception in didselect")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        
        return customizedHeaderView
    }
}
