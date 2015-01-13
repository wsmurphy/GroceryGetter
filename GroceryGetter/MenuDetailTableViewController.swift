//
//  MenuDetailTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/13/15.
//
//

import UIKit

class MenuDetailTableViewController: UITableViewController {
    var menu : Menu?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(IngredientTableViewCell.self, forCellReuseIdentifier: "MealTableCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = menu?.name
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menu!.numberOfMeals
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = menu?.mealArray[indexPath.row].name
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
            menu?.mealArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
