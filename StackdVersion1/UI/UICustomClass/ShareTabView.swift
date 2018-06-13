//
//  ShareTabView.swift
//  StackdVersion1
//
//  Created by Sky Xu on 6/12/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol ShareDelegate: class {
    func shareTapped()
}

class ShareTabView: UIView {
    var btn: UIButton!
    weak var delegate: ShareDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(rgb: 0xF7F7F7, a: 0.73)
        layoutNewSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss() {
        self.removeFromSuperview()
    }
    
    func layoutNewSubviews() {
        btn = UIButton(type: .custom)
        let backImg = #imageLiteral(resourceName: "share")
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setBackgroundImage(backImg, for: .normal)
        btn.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        self.isUserInteractionEnabled = true
        
        self.addSubview(btn)
        self.setConstraints()
    }
    
    func setConstraints() {
        btn.snp.makeConstraints { (make) in
            let height = self.bounds.size.height
            make.bottom.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(height)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func shareTapped() {
        delegate?.shareTapped()
    }
}
