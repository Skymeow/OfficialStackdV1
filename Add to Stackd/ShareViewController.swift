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
    var successSaveView: AlertView!
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseIn, animations: { [unowned self] in
            guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
            self.successSaveView = successView
            //            FIXME: view appear on top left corner and then center, why?
            self.successSaveView.configureView(title: "Saved to Stacked", at: self.view.center)
            self.view.addSubview(self.successSaveView)
            }, completion: { finished in
                self.successSaveView.isHidden = true
                print("view disappered")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let extensionItem = extensionContext?.inputItems.first as! NSExtensionItem
        
        //        for youtube
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
                                self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                            }
                        }
                        
                    }
                })
                //                for podcast
            } else if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let url = item as? NSURL {
                        let urlStr = url.absoluteString
                        //                        instantiate coredata MO for podcast
                        let podcast = Podcast(context: self.coreDataStack.privateContext)
                        podcast.urlStr = urlStr
                        self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                    }
                })
                //               safari
            } else if itemProvider.hasItemConformingToTypeIdentifier(String(kUTTypePropertyList)) {
                itemProvider.loadItem(forTypeIdentifier: String(kUTTypePropertyList), options: nil, completionHandler: { [unowned self] (item, error) -> Void in
                    if let dictionary = item as? NSDictionary {
                        OperationQueue.main.addOperation {
                            if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                                let urlStr = results["URL"] as? String {
                                let safari = Safari(context: self.coreDataStack.privateContext)
                                safari.urlStr = urlStr
                                self.coreDataStack.saveTo(context: self.coreDataStack.privateContext)
                            }
                            
                        }
                    }
                })
                
            }
        }
    }
    
    //    override func loadView() {
    //        super.loadView()
    //        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: { [unowned self] in
    //            guard let successView = Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)![0] as? AlertView else { return }
    //            self.successSaveView = successView
    //            self.successSaveView.configureView(title: "Saved to Stacked", at: self.view.center)
    //            self.view.addSubview(self.successSaveView)
    //            }, completion: { finished in
    //                self.successSaveView.isHidden = true
    //                print("view disappered")
    //        })
    //    }
    
    
}


