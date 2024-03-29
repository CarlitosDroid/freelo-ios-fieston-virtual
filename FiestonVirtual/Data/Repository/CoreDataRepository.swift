//
//  CoreDataRepository.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/7/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import CoreData

/// Enum for CoreData related errors
enum CoreDataError: Error {
    case invalidManagedObjectType
}

/// Generic class for handling NSManagedObject subclasses.
class CoreDataRepository<T: NSManagedObject>: Repository {
    typealias Entity = T
    
    /// The NSManagedObjectContext instance to be used for performing the operations.
    private let managedObjectContext: NSManagedObjectContext
    
    /// Designated initializer.
    /// - Parameter managedObjectContext: The NSManagedObjectContext instance to be used for performing the operations.
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    /// Gets an array of NSManagedObject entities.
    /// - Parameters:
    ///   - predicate: The predicate to be used for fetching the entities.
    ///   - sortDescriptors: The sort descriptors used for sorting the returned array of entities.
    /// - Returns: A result consisting of either an array of NSManagedObject entities or an Error.
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[Entity], Error> {
        // Create a fetch request for the associated NSManagedObjectContext type.
        
        //FIXME: Investigate why Entity.fetchRequest() is not working
        //let fetchRequest = Entity.fetchRequest()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do {
            // Perform the fetch request
            if let fetchResults = try managedObjectContext.fetch(fetchRequest) as? [Entity] {
                return .success(fetchResults)
            } else {
                return .failure(CoreDataError.invalidManagedObjectType)
            }
        } catch {
            return .failure(error)
        }
    }
    
    /// Creates a NSManagedObject entity.
    /// - Returns: A result consisting of either a NSManagedObject entity or an Error.
    func create() -> Result<Entity, Error> {
        let className = String(describing: Entity.self)
        guard let managedObject = NSEntityDescription.insertNewObject(forEntityName: className, into: managedObjectContext) as? Entity else {
            return .failure(CoreDataError.invalidManagedObjectType)
        }
        return .success(managedObject)
    }
    
    /// Deletes a NSManagedObject entity.
    /// - Parameter entity: The NSManagedObject to be deleted.
    /// - Returns: A result consisting of either a Bool set to true or an Error.
    func delete(entity: Entity) -> Result<Bool, Error> {
        managedObjectContext.delete(entity)
        return .success(true)
    }
    
    func update(entityName: String, avatarName: String) {
        let updateRequest = NSBatchUpdateRequest(entityName: entityName)
        updateRequest.propertiesToUpdate = ["avatar": avatarName]
        updateRequest.resultType = .updatedObjectsCountResultType
        
        do {
            let result = try managedObjectContext.execute(updateRequest)
            print(result)
            //Will print the number of rows affected/updated
        } catch {
            
        }
        
    }
    
    func updateLocalTotalScoreOfUser(entityName: String,totalScore: Int) {
        let updateRequest = NSBatchUpdateRequest(entityName: entityName)
        updateRequest.propertiesToUpdate = ["totalScore": totalScore]
        updateRequest.resultType = .updatedObjectsCountResultType
        
        do {
            let result = try managedObjectContext.execute(updateRequest)
            print(result)
            //Will print the number of rows affected/updated
        } catch {
            
        }
        
    }
    
    func deleteAllData(entityName: String)-> Result<Bool, Error> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try self.managedObjectContext.execute(deleteRequest)
        } catch {
            return .failure(false as! Error)
        }
        return .success(true)
    }
    
    func updateLocalToken(entityName: String, token: String) {
        let updateRequest = NSBatchUpdateRequest(entityName: entityName)
        updateRequest.propertiesToUpdate = ["token": token]
        updateRequest.resultType = .updatedObjectsCountResultType
        
        do {
         try managedObjectContext.execute(updateRequest)
        } catch {
            
        }
    }

}
