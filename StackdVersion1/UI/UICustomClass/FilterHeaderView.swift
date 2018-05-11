//
//  FilterHeaderView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 4/2/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol FilterHeaderActionDelegate {
    func backTapped()
}
class FilterHeaderView: UIView {
    
    var filterHeaderDelegate: FilterHeaderActionDelegate?
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var backButton: UIButton!
    var backgroundImg: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutNewSubviews()
        //        setGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.image = #imageLiteral(resourceName: "filter_background")
        backgroundImg.isUserInteractionEnabled = true
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        titleLabel.text = "FILTER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        subTitleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        subTitleLabel.text = "Shared Items"
        subTitleLabel.textColor = .white
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        subTitleLabel.textAlignment = .left
        subTitleLabel.alpha = 0.8
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.numberOfLines = 1
        subTitleLabel.sizeToFit()
        
        backButton = UIButton(type: .custom)
        let backImg = #imageLiteral(resourceName: "back_btn")
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setBackgroundImage(backImg, for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        self.addSubview(backgroundImg)
        backgroundImg.addSubview(backButton)
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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(45)
            make.centerY.equalToSuperview()
            make.height.equalTo(55)
            make.width.equalTo(200)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(35)
            make.width.equalTo(150)
        }
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
    }
    
    @objc func backTapped() {
        filterHeaderDelegate?.backTapped()
    }
}

