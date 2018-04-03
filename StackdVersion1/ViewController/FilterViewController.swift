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
    
    @IBOutlet weak var tableView: UITableView!
    let categories = ["Articles", "Videos", "Podcasts"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 150
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FilterParamCell
        cell.filterParam.text = categories[indexPath.row]
        cell.FilterDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(tableView.frame.size.height / 3)
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150)
        let customizedHeaderView = CustomHeaderView(frame: frame)
        
        return customizedHeaderView
    }
}

extension FilterViewController: FilterVCDelegate {
    func passCategory(sender: FilterParamCell) {
        let index = self.tableView.indexPath(for: sender)
        let category = self.categories[(index?.row)!]
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "filteredItemsVC") as! FilteredItemsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
