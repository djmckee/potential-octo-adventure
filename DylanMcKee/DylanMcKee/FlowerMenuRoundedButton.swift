//
//  FlowerMenuRoundedButton.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit
import QuartzCore

class FlowerMenuRoundedButton: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // we need a clear background colour by default...
        self.backgroundColor = UIColor.clearColor()
        
        // users need to tap or drag these buttons...
        self.userInteractionEnabled = true

        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // Make corners sufficiently rounded and add border!
        // Clip off pieces of the view that aren't in the circle.
        self.layer.masksToBounds = true
        
        // set the corner radius to half of the full width (making things properly circular).
        self.layer.cornerRadius = (self.frame.size.width / 2)
        
        // add a little off white border to it all
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.9).CGColor
        
    }
    

}
