//
//  ListImg.swift
//  imgGenerator
//
//  Created by Sky Xu on 6/10/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ListImg: UIView {
    
    var backgroundImg: UIImageView!
    var view1: UILabel!
    var view2: UILabel!
    var view3: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.clipsToBounds = true 
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 25))
        backgroundImg.contentMode = .scaleAspectFill
        backgroundImg.image = #imageLiteral(resourceName: "share_header")
        
        view1 = UILabel(frame:  CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        view1.font = UIFont.boldSystemFont(ofSize: 16)
        view1.numberOfLines = 3
        view1.textAlignment = .left
        view1.backgroundColor = .white
       
        view2 = UILabel(frame:  CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        view2.font = UIFont.boldSystemFont(ofSize: 16)
        view2.numberOfLines = 3
        view2.textAlignment = .left
        
        view3 = UILabel(frame:  CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30))
        view3.numberOfLines = 3
        view3.font = UIFont.boldSystemFont(ofSize: 16)
        view3.textAlignment = .left
        
        self.addSubview(backgroundImg)
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        backgroundImg.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(33)
        }
       
        view1.snp.makeConstraints { (make) in
            make.top.equalTo(backgroundImg.snp.bottom)
            make.height.greaterThanOrEqualTo(35)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        view2.snp.makeConstraints { (make) in
            make.top.equalTo(view1.snp.bottom)
            make.height.greaterThanOrEqualTo(35)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        view3.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom)
            make.height.greaterThanOrEqualTo(35)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
}
