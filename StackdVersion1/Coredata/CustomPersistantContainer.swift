//
//  CustomPersistantContainer.swift
//  StackdVersion1
//
//  Created by Sky Xu on 3/31/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CoreData

class CustomPersistantContainer : NSPersistentContainer {
    static let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.sky.StackedVersion1")!
    let storeDescription = NSPersistentStoreDescription(url: url)
    override class func defaultDirectoryURL() -> URL {
        return url
    }
    
}
