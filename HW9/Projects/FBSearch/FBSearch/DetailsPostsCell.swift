//
//  DetailsPostsCell.swift
//  FBSearch
//
//  Created by Matheos Asfaw on 4/15/17.
//  Copyright © 2017 MADesign. All rights reserved.
//

import UIKit


class DetailsPostsCell: UITableViewCell {

   
    @IBOutlet weak var messageBox: UILabel!

    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
