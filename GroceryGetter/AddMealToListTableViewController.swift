//
//  AddMealToListTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/14/15.
//
//

import UIKit
import CoreData

class AddMealToListTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var mealsToAddArray = [Int]()
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.mealArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AddMealCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        let meal = appDelegate.mealArray[indexPath.row]
        cell.textLabel!.text = meal.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        mealsToAddArray.append(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
        mealsToAddArray = mealsToAddArray.filter { $0 != indexPath.row }
    }
    
    @IBAction func doneButtonTapped(sender: AnyObject) {
        let managedContext = appDelegate.managedObjectContext!
        
        if(!appDelegate.list.isEmpty) {
            let managedList = appDelegate.list[0]
            
            _ = NSEntityDescription.entityForName("Meal", inManagedObjectContext: managedContext)
            let ingredients = NSMutableSet(capacity: mealsToAddArray.count)
            ingredients.addObjectsFromArray(appDelegate.list[0].ingredients.allObjects)
            for mealIndex in mealsToAddArray {
                let managedMeal = appDelegate.mealArray[mealIndex]
                ingredients.addObjectsFromArray(managedMeal.ingredients.allObjects)
            }
        
            managedList.setValue(ingredients, forKey: "ingredients")
            
            
            appDelegate.saveContext()
            
            appDelegate.retreiveList()
        } else {
            //Create New List
            print("New List")
            let listEntity = NSEntityDescription.entityForName("List", inManagedObjectContext: managedContext)
            let managedList = NSManagedObject(entity: listEntity!, insertIntoManagedObjectContext:managedContext)
            
            _ = NSEntityDescription.entityForName("Meal", inManagedObjectContext: managedContext)
            let ingredients = NSMutableSet(capacity: mealsToAddArray.count)
            for mealIndex in mealsToAddArray {
                let managedMeal = appDelegate.mealArray[mealIndex]
                ingredients.addObjectsFromArray(managedMeal.ingredients.allObjects)
            }
            
            managedList.setValue(ingredients, forKey: "ingredients")
            
            appDelegate.saveContext()
            
            appDelegate.retreiveList()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}
