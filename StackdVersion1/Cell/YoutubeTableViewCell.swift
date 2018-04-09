//
//  YoutubeTableViewCell.swift
//  StackdVersion1
//
//  Created by Sky Xu on 3/31/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLogo: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var sourceImg: UIImageView!
    
    @IBOutlet weak var sourceTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
