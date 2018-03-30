//
//  Reg.swift
//  StackedV1
//
//  Created by Sky Xu on 3/26/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation

//Reg for string

extension String {
    func getYoutubeId() -> String? {
        return URLComponents(string: self)?.queryItems?.first(where: {$0.name == "v"})?.value
    }
    
    func formatDuration() -> String {
        var replace = self.replacingOccurrences(of: "H", with: " Hour, ")
        replace = replace.replacingOccurrences(of: "M", with: " Minutes, ")
        replace = replace.replacingOccurrences(of: "S", with: " Seconds")
        replace = replace.replacingOccurrences(of: "PT", with: "")
        
        return replace
    }
}
