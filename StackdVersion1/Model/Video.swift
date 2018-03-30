//
//  Video.swift
//  StackedV1
//
//  Created by Sky Xu on 3/27/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation

struct Video {
    let thumbnailUrl: String
    let duration: String
    let videoTitle: String
    
    init(thumbnailUrl: String, duration: String, videoTitle: String) {
        self.thumbnailUrl = thumbnailUrl
        self.duration = duration
        self.videoTitle  = videoTitle
    }
   
}
//FIXME: change into decodable later

//extension Video: Codable {
//    enum ResultKeys: String, CodingKey {
//        case snippet
//        case
//    }
//}

