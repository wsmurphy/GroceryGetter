//
//  List.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/13/15.
//
//

import UIKit
import CoreData

class List: NSObject {
   
    var name = ""
    var ingredientArray : [AnyObject] = []
    var mealArray : [AnyObject] = []
    var menuArray : [AnyObject] = []
    
    init(managedObject: NSManagedObject) {
        super.init()
        
        name = managedObject.valueForKey("name") as String
        
        ingredientArray = managedObject.mutableSetValueForKey("containedIngredients").allObjects as NSArray
        mealArray = managedObject.mutableSetValueForKey("containedMeals").allObjects as NSArray
        menuArray = managedObject.mutableSetValueForKey("containedMenus").allObjects as NSArray
    }
   
}
