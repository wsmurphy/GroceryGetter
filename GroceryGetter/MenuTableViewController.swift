//
//  MenuTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class MenuTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return appDelegate.menuArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let menu = appDelegate.menuArray[indexPath.row]
        cell.textLabel?.text = menu.name
        if(menu.numberOfMeals == 1) {
            cell.detailTextLabel?.text = "\(menu.numberOfMeals) meal"
        } else {
            cell.detailTextLabel?.text = "\(menu.numberOfMeals) meals"
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuDetailTableViewController") as! MenuDetailTableViewController
        vc.menu = appDelegate.menuArray[indexPath.row]
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
            managedContext.deleteObject(appDelegate.menuArray[indexPath.row])
            do {
                try managedContext.save()
            } catch _ {
                print("Error saving context")
            }
            
            appDelegate.menuArray.removeAtIndex(indexPath.row)

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

}
