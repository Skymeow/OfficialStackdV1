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
        guard let successView = Bundle.main.loadNibNamed("FadingAlertView", owner: self, options: nil)![0] as? FadingAlertView else { return }
        successView.configureView(title: "Saved", at: self.view.center)
        self.view.addSubview(successView)
        
        
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
                                let id = UUID().uuidString
                                youtube.id = id
                                youtube.duration  = result?.duration
                                youtube.videoThumbnail = result?.thumbnailUrl
                                youtube.title = result?.videoTitle
                                youtube.cellType = "youtube"
                                youtube.date = Date()
                                youtube.rearrangedRow = -1
                                youtube.archived = false
                            }
                            //    run these three task in serial queue async
                            let queue = DispatchQueue(label: "synctask")
                            queue.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                                successView.hide()
                                self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                            })
                        }
                        
                    }
                })
                // for podcast
            } else if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let url = item as? NSURL {
                        let title = url.cutStringPath()
                        let urlStr = url.absoluteString
                        let id = UUID().uuidString
                        //   instantiate coredata MO for podcast
                        let podcast = Podcast(context: self.coreDataStack.privateContext)
                        podcast.urlStr = urlStr
                        podcast.title = title
                        podcast.duration = "N/A"
                        podcast.cellType = "podcast"
                        podcast.date = Date()
                        podcast.rearrangedRow = -1
                        podcast.archived = false
                        podcast.id = id
                    }
                    
                    let queue = DispatchQueue(label: "synctask")
                    queue.asyncAfter(deadline: .now() + .seconds(2), execute: {
                        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                        successView.hide()
                        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                    })
                })
                // safari
            } else if itemProvider.hasItemConformingToTypeIdentifier(String(kUTTypePropertyList)) {
                itemProvider.loadItem(forTypeIdentifier: String(kUTTypePropertyList), options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let dictionary = item as? NSDictionary {
                        OperationQueue.main.addOperation {
                            if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                                let title = results["title"] as? String,
                                let urlStr = results["URL"] as? String, let i = results["pageSource"] as? String{
                                let safari = Safari(context: self.coreDataStack.privateContext)
                                let id = UUID().uuidString
                                safari.id = id
                                safari.videoThumbnail = i 
                                safari.urlStr = urlStr
                                safari.title = title
                                safari.cellType = "safari"
                                safari.date = Date()
                                safari.rearrangedRow = -1
                                safari.archived = false
                                Networking.instance.analyzeTime(url: urlStr) { (success, timeStr) in
                                    if success {
                                       safari.duration = timeStr
                                    } else {
                                         safari.duration = "N/A"
                                    }
                                    let queue = DispatchQueue(label: "synctask")
                                    queue.asyncAfter(deadline: .now() + .seconds(2), execute: {
                                        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                                        successView.hide()
                                        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
                                    })
                                }
                                
                            }
                            
                        }
                    }
                })
                
            }
        }
    }
    deinit {
        
    }
    
}


