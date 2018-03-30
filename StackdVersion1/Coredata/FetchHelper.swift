//
//  FetchHelper.swift
//  StackedV1
//
//  Created by Sky Xu on 3/28/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CoreData

enum Route {
    case podcast
    case youtube
    case safari
}

//MARK: fetch one and all entities from viewContext

func fetchOne<T: NSManagedObject>(_ entityName: T.Type, sortDescriptor: [NSSortDescriptor]? = nil, route: Route) -> T {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.viewContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return (results?.first)!
}

//MARK: fetch all entities from viewContext

func fetchAll<T: NSManagedObject>(_ entityName: T.Type, route: Route, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
   
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.viewContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return results!
}






