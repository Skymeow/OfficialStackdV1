//
//  StackdWebLabelView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/18/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol WebActionDelegate {
    func backTapped()
}
class StackdWebLabelView: UIView {
    var btn: UIButton!
    var titleLabel: UILabel!
    var delegate: WebActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        btn = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        btn.backgroundColor = .black
        btn.setBackgroundImage(#imageLiteral(resourceName: "back_btn"), for: .normal)
        
        btn.addTarget(self, action: #selector(viewTapped), for: .touchUpInside)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        titleLabel.text = "Stackd"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        self.addSubview(btn)
        self.addSubview(titleLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        btn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(1)
            make.left.equalToSuperview().offset(3)
            make.right.equalTo(titleLabel.snp.left).offset(1)
            make.width.equalTo(25)
            make.height.equalTo(self.bounds.height - 2)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(self.bounds.height)
            make.width.equalTo(55)
        }
        
    }
    
    @objc func viewTapped() {
        delegate?.backTapped()
    }
}
