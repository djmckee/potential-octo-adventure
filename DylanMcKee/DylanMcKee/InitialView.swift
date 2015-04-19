//
//  InitialView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 17/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

class InitialView: UIView {
    
    // instance reference to the pulsating label so that we can un-hide it safely on a timer...
    private var slideToBeginLabel:PulsatingLabel!

    private func commonInit() {
        // we need a clear background colour.
        self.backgroundColor = UIColor.clearColor()
        
        // add our pulsating label and other labels (feat. animations).
        
        let helloLabel:FlatLabel = FlatLabel(frame: CGRectMake(0, 40, self.frame.size.width, 55))
        helloLabel.text = "Hello."
        helloLabel.alpha = 0.0
        self.addSubview(helloLabel)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            // fade in initial hello label
            helloLabel.alpha =  1.0
        })
        
        let nameLabel:FlatLabel = FlatLabel(frame: CGRectMake(0, (helloLabel.frame.origin.y + helloLabel.frame.size.height), self.frame.size.width, 100))
        nameLabel.text = "I'm Dylan."
        nameLabel.alpha = 0.0
        self.addSubview(nameLabel)
        
        UIView.animateWithDuration(1.0, delay: 1.0, options: nil, animations: { () -> Void in
            //fade in name label
            nameLabel.alpha = 1.0
        }, completion: nil)
        
        // compute location for the 'slide to begin' label - we want it the same width of the view, 50px in height, and 50px from the bottom
        let slideLabelHeight:CGFloat = 100.0
        let slideToBeginRect:CGRect = CGRectMake(0, (self.frame.size.height - slideLabelHeight), self.frame.size.width, slideLabelHeight)
        
        slideToBeginLabel = PulsatingLabel(frame: slideToBeginRect)
        
        slideToBeginLabel.text = "slide to begin >"
        
        // hide the label for an initial 2 seconds so other labels can load first...
        slideToBeginLabel.hidden = true
        
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("unhideLabel"), userInfo: nil, repeats: false)
        
        // add it to the view
        self.addSubview(slideToBeginLabel)
        
    }
    
    func unhideLabel(){
        slideToBeginLabel.hidden = false
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
