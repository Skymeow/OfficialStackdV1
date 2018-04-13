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

protocol FilterHeaderActionDelegate {
    func backTapped()
}
class FilterHeaderView: UIView {
    
    var filterHeaderDelegate: FilterHeaderActionDelegate?
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var backButton: UIButton!
    
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
        titleLabel.text = "FILTER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
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
        
        backButton = UIButton(type: .custom)
        let backImg = UIImage(named: "back_btn")
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setBackgroundImage(backImg, for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
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
        
        backButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.height.equalTo(titleLabel.snp.height)
            make.width.equalTo(45)
        }
        
    }
    
    @objc func backTapped() {
        filterHeaderDelegate?.backTapped()
    }
}

