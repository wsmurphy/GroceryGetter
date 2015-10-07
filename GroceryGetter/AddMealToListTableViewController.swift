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
            let meals = NSMutableSet(capacity: mealsToAddArray.count)
            for mealIndex in mealsToAddArray {
                let managedMeal = appDelegate.mealArray[mealIndex]
                meals.addObject(managedMeal)
            }
            meals.addObjectsFromArray(managedList.meals.allObjects)
            managedList.setValue(meals, forKey: "meals")
            
            do {
                try managedContext.save()
            } catch _ {
                print("Could not save context")
            }
            
            appDelegate.retreiveList()
        } else {
            //Create New List
            print("New List")
            let listEntity = NSEntityDescription.entityForName("List", inManagedObjectContext: managedContext)
            let managedList = NSManagedObject(entity: listEntity!, insertIntoManagedObjectContext:managedContext)
            
            _ = NSEntityDescription.entityForName("Meal", inManagedObjectContext: managedContext)
            let meals = NSMutableSet(capacity: mealsToAddArray.count)
            for mealIndex in mealsToAddArray {
                let managedMeal = appDelegate.mealArray[mealIndex]
                meals.addObject(managedMeal)
            }
            managedList.setValue(meals, forKey: "meals")
            
            appDelegate.saveContext()
            
            appDelegate.retreiveList()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
