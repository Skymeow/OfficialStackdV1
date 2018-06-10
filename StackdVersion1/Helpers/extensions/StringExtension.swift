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
        var replace = self.replacingOccurrences(of: "PT", with: "")
        replace = replace.replacingOccurrences(of: "H", with: "h ")
        replace = replace.replacingOccurrences(of: "M", with: "min ")
        replace = replace.replacingOccurrences(of: "S", with: "s")

        return replace
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
        let replace = self.split(separator: ":")
        var cleaned = ""
        guard self.count != 0 && self != "N/A" else { return self }
        if replace.count == 3 {
            cleaned = replace[0] + "h " + replace[1] + "min " + replace[2] + "s"
        } else if replace.count == 2 {
            cleaned = replace[0] + "min " + replace[1] + "s"
        } else {
            cleaned = replace[0] + "s"
        }
        return cleaned
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
