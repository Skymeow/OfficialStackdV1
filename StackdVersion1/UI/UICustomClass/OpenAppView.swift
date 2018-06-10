//
//  OpenAppView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 6/9/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class OpenAppView: UIView {
    var imgView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
       
        imgView = UIImageView(frame: self.frame)
        imgView.contentMode = .scaleAspectFill
        imgView.image = #imageLiteral(resourceName: "openAppView")
        self.addSubview(imgView)
        self.setConstraints()
    }
    
    func setConstraints() {
        imgView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}
