//
//  Meal.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/1/15.
//
//

import CoreData

class Meal: NSManagedObject {
    
    @NSManaged var name : String
    @NSManaged var ingredients : NSSet
    @NSManaged var lastModifiedDate: NSDate
    var numberOfIngredients: Int {
        get {
            return ingredients.count
        }
    }
}
