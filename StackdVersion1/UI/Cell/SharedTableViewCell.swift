//
//  SharedTableViewCell.swift
//  StackedV1
//
//  Created by Sky Xu on 3/27/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class SharedTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var sourceLogo: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var tagLabel1: UILabel!
    @IBOutlet weak var tagLabel2: UILabel!
    @IBOutlet weak var tagLabel3: UILabel!
    var tagsData: [Tags]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let tags = self.tagsData {
            for tag in tags{
                tagLabel1.text = tag.content ?? ""
                tagLabel1.adjustsFontSizeToFitWidth = true
                tagLabel2.text = tag.content ?? ""
                tagLabel2.adjustsFontSizeToFitWidth = true
                tagLabel3.text = tag.content ?? ""
                tagLabel3.adjustsFontSizeToFitWidth = true
            }
        }
    }
}
