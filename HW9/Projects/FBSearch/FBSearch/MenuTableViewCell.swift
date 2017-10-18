//
//  MenuTableViewCell.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/12/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var lblMenuName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
