//
//  HomeTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
 /*   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Dequeue a random cell in case we don't fall into one of these cases
        if(indexPath.section == 0) {
            return dequeueMenuCell()
        }
        
        //If we're in any section, other than the first, use the menu cell
        return dequeueMealCell()
    }
    
    func dequeueMenuCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuTableViewCell
        
        //TODO: Test value
        let numMeals = 9
        
        //TODO: Replace with menu name and meal count from data source
        cell.menuNameLabel.text = "Test Menu"
        cell.numOfMealsLabel.text = "\(numMeals) meals"
        return cell
    }
    
    func dequeueMealCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell") as MealTableViewCell
        
        //TODO: Test value
        let numItems = 5
        
        //TODO: Replace with menu name and meal count from data source
        cell.mealNameLabel.text = "Test Meal"
        cell.numOfItemsLabel.text = "\(numItems) items"
        
        return cell
    } 
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    } */
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Meals"
        } else if (section == 1) {
            return "Menus"
        }
        
        return "Default"
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
