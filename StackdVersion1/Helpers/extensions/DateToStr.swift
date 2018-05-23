//
//  DateToStr.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        let str = formatter.string(from: self)
        
        return str
    }
}
