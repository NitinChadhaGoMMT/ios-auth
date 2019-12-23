//
//  DatabaseHelper.swift
//  AuthModule
//
//  Created by Nitin Chadha on 19/12/19.
//  Copyright © 2019 Nitin Chadha. All rights reserved.
//

import UIKit
import CoreData

class DBHelper {
    
    var moc: NSManagedObjectContext?
    
    static let shared = DBHelper()
    
    private init() { }
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url  = self.applicationDocumentsDirectory.appendingPathComponent("UserData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true,
                NSSQLitePragmasOption : ["journal_mode": "DELETE"]
                ] as [String : Any]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = AuthUtils.bundle.url(forResource: "UserData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func createNewUserEntity() -> User? {
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as? User
        return user
    }
    
    func fetchUser(withPredicate predicate: NSPredicate? = nil) -> User? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = predicate
        do {
            let userCollection = try managedObjectContext.fetch(fetchRequest) as? [User]
            return userCollection?.first
        } catch {
            return nil
        }
    }
}
