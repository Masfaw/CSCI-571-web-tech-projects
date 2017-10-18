//
//  ResultsCell.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/13/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit

class ResultsCell: UITableViewCell {
    
    
    
    @IBOutlet weak var userProfileIcon: UIImageView!

    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var userFavsIcon: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
