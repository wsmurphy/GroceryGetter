//
//  Menu.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/1/15.
//
//

import CoreData

class Menu: NSManagedObject {
   
    @NSManaged var name : String
    @NSManaged var meals : NSSet
    var numberOfMeals: Int {
        get {
            return meals.count
        }
    }
}
