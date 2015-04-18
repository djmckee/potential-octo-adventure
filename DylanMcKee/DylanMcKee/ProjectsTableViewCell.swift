//
//  ProjectsTableViewCell.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    
    // the large label
    @IBOutlet weak var mainLabel:UILabel!
    
    // and 'subtitle' label
    @IBOutlet weak var subLabel:UILabel!
    
    // background image view
    @IBOutlet weak var backgroundImageView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
