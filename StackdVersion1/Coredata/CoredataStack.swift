//
//  CoredataStack.swift
//  StackedV1
//
//  Created by Sky Xu on 3/28/18.
//  Copyright © 2018 Sky Xu. All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataStack {
    static let instance = CoreDataStack()
    
    private lazy var persistentContainer: CustomPersistantContainer = {
        let container = CustomPersistantContainer(name: "SharedItems")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let viewContext = persistentContainer.viewContext
        return viewContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    func saveTo(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

