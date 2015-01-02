//
//  Meal.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/1/15.
//
//

import UIKit

class Meal: NSObject {
    
    var mealName : String = ""
    var ingredientArray : Array<String> = []
    var numberOfIngredients: Int {
        get {
            return ingredientArray.count
        }
    }
}
