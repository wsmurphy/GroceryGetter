//
//  AddIngredientTableViewCell.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 1/2/15.
//
//

import UIKit

protocol AddIngredientCellDelegate {
    func ingredientNameEdited(ingredientName:String, indexPath:NSIndexPath)
}

class AddIngredientTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var ingredientNameTextField: UITextField!
    var cellIndexPath:NSIndexPath?
    var delegate:AddIngredientCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ingredientNameTextField.delegate = self
    }

    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.textColor = UIColor.blackColor()
        textField.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("Did end editing")
        delegate?.ingredientNameEdited(textField.text!, indexPath:cellIndexPath!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.ingredientNameTextField.resignFirstResponder()
        return true
    }
}
