//
//  ShowIfEmptyView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/28/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Gifu

class ShowIfEmptyView: UIView {
    var imgView: GIFImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutNewSubviews() {
        self.isUserInteractionEnabled = true
        imgView = GIFImageView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        imgView.animate(withGIFNamed: "showIfEmpty") {
        }
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
