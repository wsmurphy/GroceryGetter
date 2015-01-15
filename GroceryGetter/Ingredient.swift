//
//  Ingredient.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/11/15.
//
//

import CoreData

class Ingredient: NSManagedObject {
    @NSManaged var name : String
    @NSManaged var inMeal : Meal
}
