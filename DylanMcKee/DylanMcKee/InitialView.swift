//
//  InitialView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 17/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class InitialView: UIView {

    func commonInit() {
        // add our pulsating label and other labels (feat. animations).
        
        // compute location for the 'slide to begin' label - we want it the same width of the view, 50px in height, and 50px from the bottom
        let slideLabelHeight:CGFloat = 100.0
        let slideToBeginRect:CGRect = CGRectMake(0, (self.frame.size.height - slideLabelHeight), self.frame.size.width, slideLabelHeight)
        
        let slideToBeginLabel:PulsatingLabel = PulsatingLabel(frame: slideToBeginRect)
        
        slideToBeginLabel.text = "slide to begin >"
        
        // add it to the view
        self.addSubview(slideToBeginLabel)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
