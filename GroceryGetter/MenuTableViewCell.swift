//
//  MenuTableViewCell.swift
//  GroceryGetter
//
//  Created by Murphy, Stephen - William S on 12/29/14.
//
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var numOfMealsLabel: UILabel!
    @IBOutlet weak var menuNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
