//
//  NewListTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/13/15.
//
//

import UIKit
import CoreData

class NewListTableViewController: UITableViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var rowArray = [Ingredient]()
    
    var isAddingIngredient = false
    
    override func viewWillAppear(animated: Bool) {
        //Register for keyboard notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        setRowArray()
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if appDelegate.list.count > 0 {
            count = appDelegate.list[0].ingredients.count
        } else {
            count = 0
        }
        
        if self.isAddingIngredient {
            count++
        }
        
        
        return count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.isAddingIngredient && indexPath.row == self.tableView.numberOfRowsInSection(indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! AddIngredientTableViewCell
            cell.delegate = self
            cell.cellIndexPath = indexPath
            cell.ingredientNameTextField.becomeFirstResponder()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("ListItemCell", forIndexPath: indexPath) as UITableViewCell
            
            // Configure the cell...
            let ingredient = rowArray[indexPath.row]
            cell.textLabel?.text = ingredient.name
            cell.detailTextLabel?.text = ingredient.inMeal.name
            
            return cell
        }
    }

    @IBAction func addFromMenuButtonTapped(sender: AnyObject) {
        //Unimplemented for now (button hidden on storyboard)
    }
    
    @IBAction func addIngredientButtonTapped(sender: AnyObject) {
        //Set the isAdding flag, then scroll the view to set the add cell visible
        self.isAddingIngredient = true
//
//        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: appDelegate.list[0].ingredients.count - 1, inSection: 0), atScrollPosition: .Bottom, animated: true)
        
        self.tableView.reloadData()
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let item = appDelegate.list[0].ingredients.allObjects[indexPath.row] as! Ingredient
            let mutableIngredients = appDelegate.list[0].mutableSetValueForKey("ingredients")
            mutableIngredients.removeObject(item)
            
            appDelegate.saveContext()
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
//        self.tableView.reloadData()
    }
    
    func keyboardWasShown(notification: NSNotification) {
        if let info = notification.userInfo {
            let size = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, size.height, 0.0)
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, size.height, 0.0)
        }
    }
    
    //FIXME: When resetting the insets, the "Add Item" row gets hidden by the scroll
    func keyboardDidHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsetsZero
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    func setRowArray() {
        if appDelegate.list.count > 0 {
            rowArray = appDelegate.list[0].ingredients.allObjects as! [Ingredient]
            //TODO: Sort
            //Removing sort for now, as it messes with add\delete order
//            rowArray.sortInPlace { x, y in
//                return x.inMeal.name < y.inMeal.name
//            }
        }
    }
}

extension NewListTableViewController : AddIngredientCellDelegate {
    func ingredientNameEdited(ingredientName: String, indexPath: NSIndexPath) {
        self.isAddingIngredient = false
        
        //If no ingredient name was entered, just return
        if ingredientName.characters.count == 0 {
            return
        }
        
        //TODO: Add ingredient to list
        let managedContext = appDelegate.managedObjectContext!
        let ingredientEntity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: managedContext)

        let managedIngredient = NSManagedObject(entity: ingredientEntity!, insertIntoManagedObjectContext:managedContext)
        managedIngredient.setValue(ingredientName, forKey: "name")
        
        let mutableIngredients = appDelegate.list[0].mutableSetValueForKey("ingredients")
        mutableIngredients.addObject(managedIngredient)
        
        setRowArray()
        
        self.tableView.reloadData()
    }
}
