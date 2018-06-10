//
//  Networking.swift
//  StackedV1
//
//  Created by Sky Xu on 3/25/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Networking {
    static let instance = Networking()
    
    func analyzeTime(url: String, completion: @escaping (_ success: Bool, _ time: String?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        
        /* Create session, and optionally set a URLSessionDelegate. */
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard var URL = URL(string: "https://api.readable.io/api/url/") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        // Headers
        let date = Date().timeIntervalSince1970
        let dateStr = Int(date)
        let toEncodeStr = "Y2KVO9BR102TFTDE3XN6YLMCVMQXA7O8" + "\(dateStr)"
        let md5Signature = toEncodeStr.md5()!

        request.addValue("UTF-8", forHTTPHeaderField: "Accept-Charset")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(md5Signature)", forHTTPHeaderField: "API_SIGNATURE")
        request.addValue("rsSession=i4u4tvsc7qod2doidk42bdtgt3", forHTTPHeaderField: "Cookie")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(dateStr)", forHTTPHeaderField: "API_REQUEST_TIME")
        
        // JSON Body
        
        let bodyObject: [String : Any] = ["url": url]
        request.httpBody = try! JSONSerialization.data(withJSONObject: bodyObject, options: [])
        
        /* Start a new Task */
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    do{
                        let r = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                        let re = r!["reading_time"] as! String
                        completion(true, re)
                    } catch {
                        print("parse reading time from api failed")
                    }
                } else{
                    completion(false, "")
                }
            } else {
                // Failure\
                completion(false, "")
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    func getYoutubeDetail(youtubeUrl: String, completion: @escaping(_ success: Bool, _ result: Video?) -> Void) {
        let baseUrl = "https://www.googleapis.com/youtube/v3/videos/"
        let videoId = youtubeUrl.getYoutubeId()!
        let params = ["part": "snippet, contentDetails",
                      "id": videoId,
                      "key": KeyCenter.youtube_key
                      ]
        Alamofire.request("https://www.googleapis.com/youtube/v3/videos/", method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    guard let json = response.result.value as? [String: Any] else { return }
                    let i = json["items"] as AnyObject
//                    key value coding (kVC)
                    let rawDuration = i.value(forKeyPath: "contentDetails.duration") as! [Any]
                    let rawVideoTitle = i.value(forKeyPath: "snippet.title") as! [Any]
                    let rawThumbnailUrl = i.value(forKeyPath: "snippet.thumbnails.default.url") as! [Any]
                    
                    var duration = rawDuration[0] as! String
                    duration = duration.formatDuration()
                    let videoTitle = rawVideoTitle[0] as! String
                    let thumbnailUrl = rawThumbnailUrl[0] as! String
                    let video = Video(thumbnailUrl: thumbnailUrl, duration: duration, videoTitle: videoTitle)
                    completion(true, video)
                   
                }
                else {
                    completion(false, nil)
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }

        
    }
    
}
