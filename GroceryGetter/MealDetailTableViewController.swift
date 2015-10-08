//
//  MealDetailTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/4/15.
//
//

import UIKit

class MealDetailTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(IngredientTableViewCell.self, forCellReuseIdentifier: "IngredientTableCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = meal?.name
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return meal!.numberOfIngredients
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableCell", forIndexPath: indexPath) as! IngredientTableViewCell

        cell.textLabel?.text = meal?.ingredients.allObjects[indexPath.row].name
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let item = meal!.ingredients.allObjects[indexPath.row] as! Ingredient
            let mutableIngredients = meal!.mutableSetValueForKey("ingredients")
            mutableIngredients.removeObject(item)
                
            appDelegate.saveContext()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
