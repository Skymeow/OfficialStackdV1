//
//  YoutubeTableViewCell.swift
//  StackdVersion1
//
//  Created by Sky Xu on 3/31/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {

    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var sourceLogo: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var sourceImg: UIImageView!
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tagsData: [Tags]?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: 45, height: 20)
        layout.sectionInset = .zero
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
    }
    
    override func layoutSubviews() {
        
    }
    
}

extension YoutubeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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

//extension YoutubeTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = CGFloat(25)
//
//        return CGSize(width: width, height: collectionView.bounds.height - 2)
//    }
//}


