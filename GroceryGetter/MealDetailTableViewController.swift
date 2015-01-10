//
//  MealDetailTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/4/15.
//
//

import UIKit

class MealDetailTableViewController: UITableViewController {
    var meal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerClass(IngredientTableViewCell.self, forCellReuseIdentifier: "IngredientTableCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = meal?.name
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return meal!.numberOfIngredients
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientTableCell", forIndexPath: indexPath) as IngredientTableViewCell

        // Configure the cell...
        cell.textLabel?.text = meal?.ingredientArray[indexPath.row].name
        return cell
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
            //TODO: Remove from Core Data meal object
            meal?.ingredientArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
