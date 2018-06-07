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
        let replace = self.replacingOccurrences(of: "PT", with: "")
        let r = replace.components(separatedBy: "M")
        let s = r[0]+" min"

        return s
    }
    
    func formatSafariUrl() -> String {
        let arr = self.components(separatedBy: "://")
        let s = arr[1].components(separatedBy: ".com")
        let f = s[0] + ".com"
        guard f.count > 3, f.hasPrefix("www.") else { return f }
        let r = String(f.dropFirst(4))
        return r
    }
    
    func formatDurationForArticle() -> String {
//        var replace = self.replacingOccurrences(of: ":", with: " Min, ")
        let replace = self.split(separator: ":")
        let mins = replace[0] + " Min"
        let fullStr = String(mins)
        
        return fullStr
    }
    
    func getSafariSource() -> String {
        let arr = self.components(separatedBy: "?")
        let source = arr[0]
        
        return source
    }
}

extension NSURL {
    func cutStringPath() -> String {
        let urlWithoutLastPath = self.deletingLastPathComponent
        let shortenedUrl = urlWithoutLastPath?.lastPathComponent
        
        return shortenedUrl!
    }
}
