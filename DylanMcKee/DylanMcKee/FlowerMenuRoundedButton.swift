//
//  FlowerMenuRoundedButton.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import QuartzCore

class FlowerMenuRoundedButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // we need a clear background colour...
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // Make corners sufficiently rounded and add border!
        self.layer.masksToBounds = true
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.9).CGColor
        
    }
    

}
