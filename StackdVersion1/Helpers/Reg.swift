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
        var replace = self.replacingOccurrences(of: "H", with: " H, ")
        replace = replace.replacingOccurrences(of: "M", with: " Min, ")
        replace = replace.replacingOccurrences(of: "S", with: " Sec")
        replace = replace.replacingOccurrences(of: "PT", with: "")
        
        return replace
    }
    
    func formatDurationForArticle() -> String {
        var replace = self.replacingOccurrences(of: ":", with: " Min, ")
        replace = replace + " Sec"
        print(replace)
        return replace
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
