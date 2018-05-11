//
//  HomeListItem.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/11/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CoreData

let coreDataStack = CoreDataStack.instance
struct ListItem: Equatable {
    let archive: Bool
    let cellType: String
    let date: Date
    let duration: String
    let rearrangedRow: Int64
    let title: String
    let urlStr: String
    let videoThumbnail: String
}

func ==(lhs: ListItem, rhs: ListItem) -> Bool {
    return lhs.archive == rhs.archive && lhs.cellType == rhs.cellType && lhs.date == rhs.date && lhs.duration == rhs.duration && lhs.rearrangedRow == rhs.rearrangedRow && lhs.title == rhs.title && lhs.urlStr == rhs.urlStr && lhs.videoThumbnail == rhs.videoThumbnail
}
//map NSManagedObject into generic model 
extension ListItem {
    init(managedItem: NSManagedObject) {
        self.archive = managedItem.value(forKey: "archive") as! Bool
        self.cellType = managedItem.value(forKey: "cellType") as! String
        self.date = managedItem.value(forKey: "date") as! Date
        self.duration = managedItem.value(forKey: "duration") as! String
        self.rearrangedRow = managedItem.value(forKey: "rearrangedRow") as! Int64
        self.title = managedItem.value(forKey: "title") as! String
        self.urlStr = managedItem.value(forKey: "urlStr") as! String
        self.videoThumbnail = managedItem.value(forKey: "videoThumbnail") as! String
    }
}
