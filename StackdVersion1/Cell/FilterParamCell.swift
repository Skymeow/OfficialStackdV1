//
//  FilterParamCell.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit


protocol FilterVCDelegate: class {
    func passCategory(sender: FilterParamCell)
}
class FilterParamCell: UITableViewCell {

    weak var FilterDelegate: FilterVCDelegate?
    @IBOutlet weak var filterParam: UILabel!
    @IBOutlet weak var FilterParamBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        FilterParamBtn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
//    @objc func btnTapped() {
//        self.FilterDelegate?.passCategory(sender: self)
//    }
}
