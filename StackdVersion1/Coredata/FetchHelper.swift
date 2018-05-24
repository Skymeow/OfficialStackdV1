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
    case allItemArchived
    case allItemUnArchived
    case tags(itemId: String)
    
    func setSortDescriptor() -> [NSSortDescriptor]? {
        switch self {
        case .podcast:
            let dateDescriptor = NSSortDescriptor(key: #keyPath(Podcast.date), ascending: true)
            let rowDescriptor = NSSortDescriptor(key: #keyPath(Podcast.rearrangedRow), ascending: true)
            return [rowDescriptor, dateDescriptor]
        case .youtube:
            let dateDescriptor = NSSortDescriptor(key: #keyPath(Youtube.date), ascending: true)
            let rowDescriptor = NSSortDescriptor(key: #keyPath(Youtube.rearrangedRow), ascending: true)
            return [rowDescriptor, dateDescriptor]
        case .safari:
            let dateDescriptor = NSSortDescriptor(key: #keyPath(Safari.date), ascending: true)
            let rowDescriptor = NSSortDescriptor(key: #keyPath(Safari.rearrangedRow), ascending: true)
            return [rowDescriptor, dateDescriptor]
        case .allItemArchived, .allItemUnArchived:
            let rowDescriptor = NSSortDescriptor(key: #keyPath(AllItem.rearrangedRow), ascending: true)
            let dateDescriptor = NSSortDescriptor(key: #keyPath(AllItem.date), ascending: false)
            return [rowDescriptor, dateDescriptor]
        case let .tags(itemId):
            return nil
        default:
            let dateDescriptor = NSSortDescriptor(key: #keyPath(AllItem.date), ascending: true)
            return [dateDescriptor]
        }
    }
    
    func setPredicate() -> NSPredicate? {
        switch self {
        case .allItemArchived:
             let result = NSPredicate(format: "archived == true")
             return result
        case .allItemUnArchived, .podcast, .safari, .youtube:
            let result = NSPredicate(format: "archived == false")
            return result
        case let .tags(itemId):
            let result = NSPredicate(format: "itemId == %@", itemId)
            return result
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
        results = try coreDataStack.privateContext.fetch(fetchRequest)
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
    let predicate = route.setPredicate()
    fetchRequest.predicate = predicate
   
    if sortDescriptor != nil {
        fetchRequest.sortDescriptors = sortDescriptor!
    } else {
        fetchRequest.sortDescriptors = route.setSortDescriptor()
    }
    
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        results = try coreDataStack.privateContext.fetch(fetchRequest)
    } catch {
        assert(false, error.localizedDescription)
    }
    
    return results!
}
