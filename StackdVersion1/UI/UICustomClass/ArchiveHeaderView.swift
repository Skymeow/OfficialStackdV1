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
    var barView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
 
        barView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 6))
        barView.backgroundColor = UIColor.lightGray
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.image = #imageLiteral(resourceName: "archive_background")
        backgroundImg.isUserInteractionEnabled = true
       
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 30))
        titleLabel.text = "ARCHIVE"
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 32)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        self.addSubview(barView)
        self.addSubview(backgroundImg)
        backgroundImg.addSubview(titleLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        barView.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundImg.snp.bottom)
            make.bottom.equalToSuperview().offset(-6)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(6)
        }
        
        backgroundImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(barView.snp.top)
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

