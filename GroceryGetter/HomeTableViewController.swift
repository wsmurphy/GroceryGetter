//
//  HomeTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class HomeTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var listButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if(indexPath.section == 0 && indexPath.row > 0) {
            if(indexPath.row >  appDelegate.mealArray.count) {
                cell.hidden = true
            } else {
                let meal = appDelegate.mealArray[indexPath.row - 1]
                cell.textLabel?.text = meal.name
                if(meal.numberOfIngredients == 1) {
                    cell.detailTextLabel?.text = "\(meal.numberOfIngredients) item"
                } else {
                    cell.detailTextLabel?.text = "\(meal.numberOfIngredients) items"
                }
                cell.hidden = false
            }
        } else if (indexPath.section == 1 && indexPath.row > 0) {
            if(indexPath.row > appDelegate.menuArray.count) {
                cell.hidden = true
            } else {
                 let menu = appDelegate.menuArray[indexPath.row - 1]
                cell.textLabel?.text = menu.name
                if(menu.numberOfMeals == 1) {
                    cell.detailTextLabel?.text = "\(menu.numberOfMeals) meal"
                } else {
                    cell.detailTextLabel?.text = "\(menu.numberOfMeals) meals"
                }
                cell.hidden = false
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0 && indexPath.row > 0) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MealDetailTableViewController") as! MealDetailTableViewController
            vc.meal = appDelegate.mealArray[indexPath.row - 1]
            self.showViewController(vc, sender: self)
        } else if(indexPath.section == 1 && indexPath.row > 0) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuDetailTableViewController") as! MenuDetailTableViewController
            vc.menu = appDelegate.menuArray[indexPath.row - 1]
            self.showViewController(vc, sender: self)
        }
    }
    
    @IBAction func listButtonTapped(sender: AnyObject) {
        if(appDelegate.mealArray.isEmpty) {
            let alertController = UIAlertController(title: "Tip", message: "Add ingredients to a meal to make building a list quick and easy!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion:nil)
        } else {
            //Currently, new list and list details is same view
            self.performSegueWithIdentifier("NewListSegue", sender: self)
        }
    }
}
