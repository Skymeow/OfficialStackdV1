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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sourceTitle: UILabel!

//    var tagsData: [String]?
    var tagsData = ["politics", "cucumber kalalalala", "dsdsfdsfadsf", "sdfsd"]
    override func awakeFromNib() {
        super.awakeFromNib()
//        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
//        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
//
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
//        layout.itemSize = CGSize(width: 45, height: 20)
//        collectionView.setCollectionViewLayout(layout, animated: false)
//        collectionView.reloadData()
        
    }
    
    override func layoutSubviews() {
        let tagCell = UINib(nibName: "TagsCell", bundle: Bundle.main)
        collectionView.register(tagCell, forCellWithReuseIdentifier: "TagsCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: 45, height: 20)
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
}

extension YoutubeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tagsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        cell.backgroundColor = .red
        let tags = self.tagsData
        //            if let tags = self.tagsData {
        cell.label.text = tags[indexPath.row]
        cell.label.adjustsFontSizeToFitWidth = true
        //            }
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

