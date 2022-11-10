//
//  MyTableViewCell.swift
//  CollectionWithTableView
//
//  Created by shalini on 02/10/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var firstname: UILabel!
   
    var imageArray = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
