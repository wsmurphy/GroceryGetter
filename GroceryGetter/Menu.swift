//
//  Menu.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/1/15.
//
//

import UIKit
import CoreData

class Menu: NSObject {
   
    var name : String = ""
    var mealArray : [AnyObject] = []
    var numberOfMeals: Int {
        get {
            return mealArray.count
        }
    }
    
    init(managedObject: NSManagedObject) {
        name = managedObject.valueForKey("name") as String
        //TODO: set date
        //   lastModifiedDate = managedObject.valueForKey("lastModifiedDate") as NSDate
        
        mealArray = managedObject.mutableSetValueForKey("containedMeals").allObjects as NSArray
        
    }
}
