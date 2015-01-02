//
//  HomeTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class HomeTableViewController: UITableViewController {
    private let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if(indexPath.section == 0 && indexPath.row > 0) {
            if(indexPath.row >  appDelegate.mealArray.count) {
                cell.hidden = true
            } else {
                cell.textLabel?.text = appDelegate.mealArray[indexPath.row - 1].mealName
                if(appDelegate.mealArray[indexPath.row - 1].numberOfIngredients == 1) {
                    cell.detailTextLabel?.text = "\(appDelegate.mealArray[indexPath.row - 1].numberOfIngredients) item"
                } else {
                    cell.detailTextLabel?.text = "\(appDelegate.mealArray[indexPath.row - 1].numberOfIngredients) items"
                }
            }
        } else if (indexPath.section == 1 && indexPath.row > 0) {
            if(indexPath.row > appDelegate.menuArray.count) {
                cell.hidden = true
            } else {
                cell.textLabel?.text = appDelegate.menuArray[indexPath.row - 1].menuName
                if(appDelegate.menuArray[indexPath.row - 1].numberOfMeals == 1) {
                    cell.detailTextLabel?.text = "\(appDelegate.menuArray[indexPath.row - 1].numberOfMeals) meal"
                } else {
                    cell.detailTextLabel?.text = "\(appDelegate.menuArray[indexPath.row - 1].numberOfMeals) meals"
                }
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
