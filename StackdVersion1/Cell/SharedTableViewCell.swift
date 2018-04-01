//
//  SharedTableViewCell.swift
//  StackedV1
//
//  Created by Sky Xu on 3/27/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class SharedTableViewCell: UITableViewCell {

    var sharedItems: [Any]? {
        didSet {
            guard let sharedItems = (sharedItems as? [Podcast])
            else { return }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
