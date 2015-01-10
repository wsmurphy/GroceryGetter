//
//  Meal.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/1/15.
//
//

import UIKit
import CoreData

class Meal: NSObject {
    
    var name = ""
    var ingredientArray : [AnyObject] = []
    var lastModifiedDate: NSDate = NSDate()
    var numberOfIngredients: Int {
        get {
            return ingredientArray.count
        }
    }
    
    
    init(managedObject: NSManagedObject) {
        super.init()

        name = managedObject.valueForKey("name") as String
        //TODO: Set date
     //   lastModifiedDate = managedObject.valueForKey("lastModifiedDate") as NSDate

        ingredientArray = managedObject.mutableSetValueForKey("containedIngredients").allObjects as NSArray
    }
}
