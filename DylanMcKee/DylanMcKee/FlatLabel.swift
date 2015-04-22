//
//  FlatLabel.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 19/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//

import UIKit

// a UILabel subclass that creates a large flat cool looking label, to save a bit of code duplication.
class FlatLabel: UILabel {

    
    private func commonInit() {
        // a common initialisation method, to abstract away from programatic/interface builder creation of the label and reduce code duplication.
        
        // center text alignment
        self.textAlignment = NSTextAlignment.Center
        
        // set a nice flat large font
        self.font = UIFont(name: Constants.superLightFontName, size: Constants.largeLabelSize)
        
        // set a white font colour
        self.textColor = UIColor.whiteColor()
        
    }
    
    override init(frame: CGRect) {
        // call the superclass
        super.init(frame: frame)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
