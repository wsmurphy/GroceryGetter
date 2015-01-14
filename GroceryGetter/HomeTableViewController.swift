//
//  HomeTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class HomeTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    @IBOutlet weak var listButton: UIButton!

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        
        
        if (appDelegate.list?.valueForKey("name") != nil) {
            listButton.titleLabel?.text = "See My List!"
        } else {
            listButton.titleLabel?.text = "Build My List!"
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if(indexPath.section == 0 && indexPath.row > 0) {
            if(indexPath.row >  appDelegate.mealArray.count) {
                cell.hidden = true
            } else {
                var meal = Meal(managedObject: appDelegate.mealArray[indexPath.row - 1])
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
                 var menu = Menu(managedObject: appDelegate.menuArray[indexPath.row - 1])
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
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MealDetailTableViewController") as MealDetailTableViewController
            vc.meal = Meal(managedObject: appDelegate.mealArray[indexPath.row - 1])
            self.showViewController(vc, sender: self)
        } else if(indexPath.section == 1 && indexPath.row > 0) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MenuDetailTableViewController") as MenuDetailTableViewController
            vc.menu = Menu(managedObject: appDelegate.menuArray[indexPath.row - 1])
            self.showViewController(vc, sender: self)
        }
    }
    
    @IBAction func listButtonTapped(sender: AnyObject) {
        //TODO: Push either the new list or list details view
    }
}
