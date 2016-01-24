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
        
        self.tableView.reloadData()
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from core data, the row array, and the tableView
            let item = appDelegate.list[0].ingredients.allObjects[indexPath.row] as! Ingredient
            let mutableIngredients = appDelegate.list[0].mutableSetValueForKey("ingredients")
            mutableIngredients.removeObject(item)
            
            //Will this work??
            appDelegate.list[0].ingredients = mutableIngredients
            
            appDelegate.dataManager.saveContext()
            
            //Sync local array with Core Data
            setRowArray()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func keyboardWasShown(notification: NSNotification) {
        if let info = notification.userInfo {
            let size = info[UIKeyboardFrameBeginUserInfoKey]!.CGRectValue.size
            self.tableView.contentInset = UIEdgeInsetsMake(0.0, 0.0, size.height, 0.0)
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, size.height, 0.0)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64.0, 0.0, 0.0, 0.0)
    }
    
    func setRowArray() {
        //Refresh list from coreData
        appDelegate.dataManager.retreiveList()
        
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
        
        //Add ingredient to list
        let managedContext = appDelegate.dataManager.managedObjectContext
        let ingredientEntity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: managedContext)

        let managedIngredient = NSManagedObject(entity: ingredientEntity!, insertIntoManagedObjectContext:managedContext)
        managedIngredient.setValue(ingredientName, forKey: "name")
        
        let mutableIngredients = appDelegate.list[0].mutableSetValueForKey("ingredients")
        mutableIngredients.addObject(managedIngredient)
        
        appDelegate.dataManager.saveContext()
        
        //Sync local array with Core Data
        setRowArray()
        
        self.tableView.reloadData()
    }
}
