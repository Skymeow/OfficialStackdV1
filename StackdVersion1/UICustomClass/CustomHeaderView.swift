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
}
class CustomHeaderView: UIView {
   
    var customedHeaderDelegate: HeaderActionDelegate?
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var filterButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        layoutNewSubviews()
//        setGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        
        titleLabel = UILabel(frame: CGRect(x: 20, y: 130, width: 180, height: 29))
        titleLabel.text = "Stacked"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textAlignment = .left
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
        
        filterButton = UIButton(type: .custom)
        let filterImg = UIImage(named: "Filter")
        filterButton.imageView?.contentMode = .scaleAspectFit
        filterButton.setBackgroundImage(filterImg, for: .normal)
        filterButton.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        
        self.addSubview(filterButton)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
       
        setConstraints()
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(45)
            make.bottom.equalTo(subTitleLabel.snp.top).offset(30)
            make.height.equalTo(55)
            make.width.equalTo(200)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(35)
            make.width.equalTo(150)
        }
        
        filterButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(55)
            make.width.equalTo(45)
        }
        
    }
    
    @objc func filterTapped() {
        customedHeaderDelegate?.filterTapped()
    }
}

