//
//  ListItemDisplayManager.swift
//  StackdVersion1
//
//  Created by Sky Xu on 5/11/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CoreData
//update the managedobject data and than map into the model I created .
class ListItemDisplayManager: NSObject, NSFetchedResultsControllerDelegate {
    var items: [ListItem]?
    var selectedItem: ListItem?
    private let coreDataStack = CoreDataStack.instance
    private var fetchResultsController: NSFetchedResultsController<NSFetchRequestResult>!
//    private var resultsCache:
    
    
}
