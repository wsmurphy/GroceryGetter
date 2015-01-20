//
//  List.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/13/15.
//
//

import CoreData

class List: NSManagedObject {
   
    @NSManaged var ingredients : NSSet
    @NSManaged var meals : NSSet
    @NSManaged var menus : NSSet
}
