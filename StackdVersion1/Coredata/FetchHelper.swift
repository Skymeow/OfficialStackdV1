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
    case allItem
    
    func setSortDescriptor() -> NSSortDescriptor? {
        switch self {
        case .podcast:
            let descriptor = NSSortDescriptor(key: #keyPath(Podcast.date), ascending: true)
            return descriptor
        case .youtube:
            let descriptor = NSSortDescriptor(key: #keyPath(Youtube.date), ascending: true)
            return descriptor
        case .safari:
            let descriptor = NSSortDescriptor(key: #keyPath(Safari.date), ascending: true)
            return descriptor
        case .allItem:
            let descriptor = NSSortDescriptor(key: #keyPath(AllItem.date), ascending: true)
            return descriptor
        default:
            return nil
        }
    }
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

//MARK: fetch all entities from viewContext by latest data and different cell type

func fetchAll<T: NSManagedObject>(_ entityName: T.Type, route: Route, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    } else {
        fetchRequest.sortDescriptors = [route.setSortDescriptor()!]
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.viewContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return results!
}

//  fetch all archived items
func fetchAllArchived<T: NSManagedObject>(_ entityName: T.Type, route: Route, sortDescriptor: [NSSortDescriptor]? = nil) -> [T] {
    var results: [T]?
    let coreDataStack = CoreDataStack.instance
    let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
    
    let result = NSPredicate(format: "archived == true")
    fetchRequest.predicate = result
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






