//
//  CustomTableViewCell.swift
//  BenguOzturk_Project
//
//  Created by Bengu H. Ozturk on 25.05.2021.
//  Copyright © 2021 Bengu H. Ozturk. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
