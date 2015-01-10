//
//  MealTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit
import CoreData

class MealTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return appDelegate.mealArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        var meal = Meal(managedObject: appDelegate.mealArray[indexPath.row])
        cell.textLabel?.text = meal.name
        if(meal.numberOfIngredients == 1) {
            cell.detailTextLabel?.text = "\(meal.numberOfIngredients) item"
        } else {
            cell.detailTextLabel?.text = "\(meal.numberOfIngredients) items"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MealDetailTableViewController") as MealDetailTableViewController
        vc.meal = Meal(managedObject: appDelegate.mealArray[indexPath.row])
        self.showViewController(vc, sender: self)
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source

            let managedContext = appDelegate.managedObjectContext!
            managedContext.deleteObject(appDelegate.mealArray[indexPath.row])
            managedContext.save(nil)
            
            appDelegate.mealArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }  
    }

}
