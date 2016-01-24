//
//  DataManager.swift
//  GroceryGetter
//
//  Created by Stephen Murphy on 11/4/15.
//
//

import UIKit
import CoreData
class DataManager: NSObject {
    static let sharedInstance = DataManager()
    
    var managedObjectContext: NSManagedObjectContext
    
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("GroceryGetter", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
            This code uses a file named "DataModel.sqlite" in the application's documents directory.
            */
            let storeURL = docURL.URLByAppendingPathComponent("GroceryGetter.sqlite")
            print(storeURL)
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
    
    func saveContext () {
        do {
            try self.managedObjectContext.save()
        } catch let error as NSError {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    //MARK - Core data fetches
    func retreiveMealArray() -> [Meal] {
        let fetchRequest = NSFetchRequest(entityName:"Meal")
        do {
            return try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Meal]
        } catch _ {
            print("Error executing mealArray fetch")
        }
        
        return [Meal()]
    }
    
    func retreiveMenuArray() -> [Menu] {
        let fetchRequest = NSFetchRequest(entityName:"Menu")
        
        do {
            return try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Menu]
        } catch _ {
            print("Error executing menuArray fetch")
        }
        
        return [Menu()]
    }
    
    func retreiveList() -> [List] {
        let fetchRequest = NSFetchRequest(entityName:"List")
        
        do {
            return try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [List]
        } catch _ {
            print("Error executing list fetch")
        }
        
        return [List()]
    }

}
