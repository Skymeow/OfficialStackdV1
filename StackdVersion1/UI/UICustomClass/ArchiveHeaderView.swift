//
//  ArchiveHeaderView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/7/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//
import Foundation
import UIKit
import SnapKit
import Kingfisher

class ArchiveHeaderView: UIView {
    
    var titleLabel: UILabel!
    var backgroundImg: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.image = #imageLiteral(resourceName: "archive_background")
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 30))
        titleLabel.text = "ARCHIVE"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        self.addSubview(backgroundImg)
        backgroundImg.addSubview(titleLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        backgroundImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(200)
        }
        
    }
}

