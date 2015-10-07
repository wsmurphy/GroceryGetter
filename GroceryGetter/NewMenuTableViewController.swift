//
//  NewMenuTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/11/15.
//
//

import UIKit
import CoreData

class NewMenuTableViewController: UITableViewController {

    @IBOutlet weak var menuNameTextField: UITextField!
    var menuName = ""
    var mealArray : [Int] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return appDelegate.mealArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        // Configure the cell...
        let meal = appDelegate.mealArray[indexPath.row]
        cell.textLabel?.text = meal.name
        cell.accessoryType = UITableViewCellAccessoryType.None;
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        mealArray.append(indexPath.row)
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
        mealArray = mealArray.filter { $0 != indexPath.row }
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func saveTapped(sender: AnyObject) {
        //Validate that we have minimum data to create a new menu
        if(menuNameTextField.text!.isEmpty == true) {
            let alert = UIAlertController(title: "Error", message: "Menu Name must be set", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in
                //Highlight meal name text field with red border
                self.menuNameTextField.layer.borderColor = UIColor.redColor().CGColor
                self.menuNameTextField.layer.borderWidth = 2.0
                self.menuNameTextField.layer.masksToBounds = true
                self.menuNameTextField.layer.cornerRadius = 8.0
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            menuName = self.menuNameTextField.text!
            saveMenu()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func saveMenu() {
        let managedContext = appDelegate.managedObjectContext!
        
        let menuEntity = NSEntityDescription.entityForName("Menu", inManagedObjectContext: managedContext)
        let managedMenu = NSManagedObject(entity: menuEntity!, insertIntoManagedObjectContext:managedContext)
        
        managedMenu.setValue(menuName, forKey: "name")
        
        //TODO: Put in MealArray from saved indexes
        _ = NSEntityDescription.entityForName("Meal", inManagedObjectContext: managedContext)
        let meals = NSMutableSet(capacity: mealArray.count)
        for arrayIndex in mealArray {
            meals.addObject(appDelegate.mealArray[arrayIndex])
        }

        managedMenu.setValue(meals, forKey: "meals")

        appDelegate.saveContext()
        appDelegate.retreiveMenuArray()
    }
}
