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
   
    @IBOutlet weak var parentView: UIView!
    var tagsData: [Tags]?
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // update UI
//        accessoryType = selected ? .checkmark : .none
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        layout.itemSize = CGSize(width: 45, height: 20)
        layout.estimatedItemSize = CGSize(width: 50, height: 20)
        layout.sectionInset = .zero
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
    }
}

extension SharedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.tagsData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        cell.backgroundColor = .lightGray
        if let tags = self.tagsData {
            cell.label.text = tags[indexPath.row].content ?? ""
            cell.label.adjustsFontSizeToFitWidth = true
        }
        return cell
    }
}
