//
//  PodcastDataServer.swift
//  StackedV1
//
//  Created by Sky Xu on 3/27/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class PodcastDataServer {
    static let instance = PodcastDataServer()
    
    func getPodcastInfo(_ podcastUrl: String) -> String {
        guard let url = URL(string: podcastUrl) else { return "podcast url failed to laod"}
        let asset = AVURLAsset(url: url, options: nil)
        var metaValue: String = ""
        let metaArr = asset.metadata
        for metadata in metaArr {
            print(metadata)
        }
        return ""
    }
}
