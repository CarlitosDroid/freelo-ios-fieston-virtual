//
//  CoreDataContextProvider.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import CoreData

class CoreDataContextProvider {
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private var persistentContainer: NSPersistentContainer
    
    init(completionClosure: ((Error?) -> Void)? = nil) {
        persistentContainer = NSPersistentContainer(name: "FiestonVirtual")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure?(error)
        }
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }

}
