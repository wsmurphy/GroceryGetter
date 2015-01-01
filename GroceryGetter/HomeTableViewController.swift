//
//  HomeTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class HomeTableViewController: UITableViewController {
    var mealArray :Array<Meal> = []
    var menuArray :Array<Menu> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Replace with actual data
        var meal = Meal()
        meal.mealName = "Meal 1"
        meal.ingredientArray = ["Item 1", "Item 2"]
        
        var meal2 = Meal()
        meal2.mealName = "Meal 2"
        meal2.ingredientArray = ["Item 3", "Item 4"]

        mealArray.append(meal)
        mealArray.append(meal2)
        
        var menu = Menu()
        menu.menuName = "Menu 1"
        menu.mealArray = [meal, meal2, meal2]
        
        var menu1 = Menu()
        menu1.menuName = "Menu 2"
        menu1.mealArray = [meal, meal2, meal2]
        
        menuArray.append(menu)
        menuArray.append(menu1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        if(indexPath.section == 0 && indexPath.row > 0) {
            if(indexPath.row > mealArray.count) {
                cell.hidden = true
            } else {
                cell.textLabel?.text = mealArray[indexPath.row - 1].mealName
                cell.detailTextLabel?.text = "\(mealArray[indexPath.row - 1].ingredientArray.count) items"
            }
        } else if (indexPath.section == 1 && indexPath.row > 0) {
            //TODO: Replace with data from menu array, instead of meal but with same logic
            if(indexPath.row > menuArray.count) {
                cell.hidden = true
            } else {
                cell.textLabel?.text = menuArray[indexPath.row - 1].menuName
                cell.detailTextLabel?.text = "\(menuArray[indexPath.row - 1].mealArray.count) meals"
            }
        }
        return cell
    }
    
 /*   func dequeueMenuCell(row:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuTableViewCell
        
        let numMeals = 5
        
        //TODO: Replace with menu name and meal count from data source
        cell.menuNameLabel.text = "Test Menu"
        cell.numOfMealsLabel.text = "\(numMeals) meals"
        return cell
    }
    
    func dequeueMealCell(row:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealCell") as MealTableViewCell

        //TODO: Replace with menu name and meal count from data source
        cell.mealNameLabel.text = mealArray[row].mealName
        cell.numOfItemsLabel.text = "\(mealArray[row].ingredientArray.count) items"
        
        return cell
    }  */
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Recent Meals"
        } else if (section == 1) {
            return "Recent Menus"
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
