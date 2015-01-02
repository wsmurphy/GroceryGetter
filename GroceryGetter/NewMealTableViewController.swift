//
//  NewMealTableViewController.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/2/15.
//
//

import UIKit

class NewMealTableViewController: UITableViewController  {
    @IBOutlet weak var mealNameTextField: UITextField!
    var meal : Meal = Meal()
    var ingredientArray : Array<String> = []
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
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
    @IBAction func saveTapped(sender: AnyObject) {
        println("Save tapped")
        
        if(mealNameTextField.text.isEmpty == true) {
            var alert = UIAlertController(title: "Error", message: "Meal Name must be set", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel){ (action) in
                //Highlight meal name text field with red border
                self.mealNameTextField.layer.borderColor = UIColor.redColor().CGColor
                self.mealNameTextField.layer.borderWidth = 1.0
                self.mealNameTextField.layer.masksToBounds = true
                self.mealNameTextField.layer.cornerRadius = 8.0
            }
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            meal.mealName = mealNameTextField.text
            appDelegate.mealArray.append(meal)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(ingredientArray.count == 0) {
            return 1
        } else {
            return ingredientArray.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        if(indexPath.row >= ingredientArray.count) {
            cell.textLabel?.text = "Tap to add ingredient"
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        } else {
            cell.textLabel?.text = ingredientArray[indexPath.row]
            cell.textLabel?.textColor = UIColor.blackColor()
            cell.selectionStyle = UITableViewCellSelectionStyle.None
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected row")
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
