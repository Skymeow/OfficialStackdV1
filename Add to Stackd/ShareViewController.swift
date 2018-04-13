//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Sky Xu on 3/21/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import CoreData

@objc (ShareViewController) class ShareViewController: UIViewController {
    
    let coreDataStack = CoreDataStack.instance
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
        successView.configureView(title: "Saved to Stacked", at: self.view.center)
        self.view.addSubview(successView)
        successView.hide()
        
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem

        //  for youtube
        if let itemProvider = extensionItem.attachments?.first as? NSItemProvider {
            if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePlainText as String, options: nil, completionHandler: { (item, error) -> Void in
                    if let string = item as? String {
                        let youtube = Youtube(context: self.coreDataStack.privateContext)
                        youtube.urlStr = string
                        Networking.instance.getYoutubeDetail(youtubeUrl: string) { (success, result) in
                            if success {
                                youtube.duration  = result.duration
                                youtube.videoThumbnail = result.thumbnailUrl
                                youtube.title = result.videoTitle
                                youtube.cellType = "youtube"
                                youtube.date = Date()
                                self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                            }
                        }
                        
                    }
                })
                // for podcast
            } else if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let url = item as? NSURL {
                        let title = url.cutStringPath()
                        let urlStr = url.absoluteString
                        //   instantiate coredata MO for podcast
                        let podcast = Podcast(context: self.coreDataStack.privateContext)
                        podcast.urlStr = urlStr
                        podcast.title = title
                        podcast.duration = "see detail in podcast app"
                        podcast.cellType = "podcast"
                        podcast.date = Date()
                        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                    }
                })
                // safari
            } else if itemProvider.hasItemConformingToTypeIdentifier(String(kUTTypePropertyList)) {
                itemProvider.loadItem(forTypeIdentifier: String(kUTTypePropertyList), options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let dictionary = item as? NSDictionary {
                        OperationQueue.main.addOperation {
                            if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                                let title = results["title"] as? String,
                                let urlStr = results["URL"] as? String {
                                let safari = Safari(context: self.coreDataStack.privateContext)
                                safari.urlStr = urlStr
                                safari.title = title
                                safari.cellType = "safari"
                                safari.date = Date()
                                Networking.instance.analyzeTime(url: urlStr) { (success, timeStr) in
                                    if success {
                                       safari.duration = timeStr
                                    } else {
                                         safari.duration = "unable to analyze time"
                                    }
                                    self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                                }
                                
                            }
                            
                        }
                    }
                })
                
            }
        }
    }
    
}


