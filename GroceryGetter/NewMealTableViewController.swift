//
//  NewMealTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/2/15.
//
//

import UIKit
import CoreData

class NewMealTableViewController: UITableViewController  {
    @IBOutlet weak var mealNameTextField: UITextField!
    var mealName = ""
    var ingredientArray : [String] = []
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mealNameTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        //TODO: Resign first responder on any cell that may be currently editing, so that we'll save the item before exiting
        
        
        //Validate that we have minimum data to create a new meal
        if(mealNameTextField.text!.isEmpty == true) {
            let alert = UIAlertController(title: "Error", message: "Meal Name must be set", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in
                //Highlight meal name text field with red border
                self.mealNameTextField.layer.borderColor = UIColor.redColor().CGColor
                self.mealNameTextField.layer.borderWidth = 2.0
                self.mealNameTextField.layer.masksToBounds = true
                self.mealNameTextField.layer.cornerRadius = 8.0
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            //TODO: Restore correct text field style, in case it was red before
        //   self.mealNameTextField.layer.borderColor = UIColor.clearColor().CGColor

            if (ingredientArray.count == 0) {
                let alert = UIAlertController(title: "Error", message: "Must have at least one ingredient", preferredStyle: UIAlertControllerStyle.Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in
                }
                alert.addAction(cancelAction)
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                //Finish updates and add this meal to the master list
                mealName = mealNameTextField.text!
                
                saveMeal()
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    func saveMeal() {
        let managedContext = appDelegate.dataManager.managedObjectContext
        
        let mealEntity = NSEntityDescription.entityForName("Meal", inManagedObjectContext: managedContext)
        let managedMeal = NSManagedObject(entity: mealEntity!, insertIntoManagedObjectContext:managedContext)
        
        managedMeal.setValue(mealName, forKey: "name")

        let ingredientEntity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: managedContext)
        let ingredients = NSMutableSet(capacity: ingredientArray.count)
        for ingredient in ingredientArray {
            let managedIngredient = NSManagedObject(entity: ingredientEntity!, insertIntoManagedObjectContext:managedContext)
            managedIngredient.setValue(ingredient, forKey: "name")
            ingredients.addObject(managedIngredient)
        }
        managedMeal.setValue(ingredients, forKey: "ingredients")
        
        appDelegate.dataManager.saveContext()

        appDelegate.dataManager.retreiveMealArray()
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if(ingredientArray.count == 0) {
            return 1
        } else {
            return ingredientArray.count + 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as! AddIngredientTableViewCell

        // Configure the cell...
        if(indexPath.row >= ingredientArray.count) {
            cell.ingredientNameTextField.text = "Tap to add ingredient"
            cell.ingredientNameTextField.textColor = UIColor.grayColor()
            cell.ingredientNameTextField.userInteractionEnabled = true
        } else {
            cell.ingredientNameTextField.text = ingredientArray[indexPath.row]
            cell.ingredientNameTextField.textColor = UIColor.blackColor()
            cell.ingredientNameTextField.userInteractionEnabled = false
        }
        cell.cellIndexPath = indexPath
        cell.delegate = self
        cell.selectionStyle = UITableViewCellSelectionStyle.None

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
            ingredientArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension NewMealTableViewController : AddIngredientCellDelegate {
    func ingredientNameEdited(ingredientName: String, indexPath: NSIndexPath) {
        if(!ingredientName.isEmpty) {
            //TODO: Allow editing previously added items, and handle updating in the array, instead of append every time
            ingredientArray.append(ingredientName)
        }
        
        self.tableView.reloadData()
    }
}

extension NewMealTableViewController : UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Shift the table view up to make sure the cell that is editing shows above the keyboard
        if let cell = textField.superview?.superview as? UITableViewCell, indexPath = self.tableView.indexPathForCell(cell) {
            self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        }
    }
}
