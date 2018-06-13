//
//  CustomNavigationbar.swift
//  StackedV1
//
//  Created by Sky Xu on 3/26/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import SnapKit

protocol HeaderActionDelegate {
    func filterTapped()
    func shareTapped()
}

class CustomHeaderView: UIView {
   
    var customedHeaderDelegate: HeaderActionDelegate?
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var filterButton: UIButton!
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
        backgroundImg.image = #imageLiteral(resourceName: "homepge_background")
        backgroundImg.isUserInteractionEnabled = true
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        titleLabel.text = "Stackd"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "Comfortaa-Bold", size: 34)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        subTitleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        subTitleLabel.text = "Share Items"
        subTitleLabel.textColor = .white
        subTitleLabel.font = UIFont(name: "SFProDisplay-Medium", size: 17)
        subTitleLabel.textAlignment = .left
        subTitleLabel.alpha = 0.8
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.numberOfLines = 1
        subTitleLabel.sizeToFit()
        let tap = UITapGestureRecognizer(target: self, action: #selector(shareTapped))
        subTitleLabel.isUserInteractionEnabled = true
        subTitleLabel.clipsToBounds = true
        subTitleLabel.addGestureRecognizer(tap)
        
        filterButton = UIButton(type: .custom)
        let filterImg = #imageLiteral(resourceName: "Filter")
        filterButton.imageView?.contentMode = .scaleAspectFit
        filterButton.setBackgroundImage(filterImg, for: .normal)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        
        self.addSubview(backgroundImg)
        backgroundImg.addSubview(filterButton)
        backgroundImg.addSubview(titleLabel)
        backgroundImg.addSubview(subTitleLabel)
       
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
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(55)
            make.width.equalTo(200)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(35)
            make.width.equalTo(150)
        }
        
        filterButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(45)
        }
        
    }
    
    @objc func filterTapped() {
        customedHeaderDelegate?.filterTapped()
        
    }
    
    @objc func shareTapped() {
        customedHeaderDelegate?.shareTapped()
    }
}

