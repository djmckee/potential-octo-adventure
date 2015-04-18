//
//  PulsatingLabel.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 17/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

// A UILabel with a pulsating background colour animation, pretty similar in concept to the label on the iOS Lock Screen.

import UIKit

class PulsatingLabel: UILabel {
    
    private func commonInit() {
        // a common initialisation method, to abstract away from programatic/interface builder creation of the label and reduce code duplication.
        
        // center text alignment
        self.textAlignment = NSTextAlignment.Center
        
        // set a nice flat large font
        self.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        
        // set a white font colour
        self.textColor = UIColor.whiteColor()
                
        self.alpha = 0.5
        
        // begin animating ourselves, constantly.
        UIView.animateKeyframesWithDuration(2.0, delay: 3.0, options: (UIViewKeyframeAnimationOptions.Repeat | UIViewKeyframeAnimationOptions.Autoreverse), animations: { () -> Void in
            // fade out (then fade back in on completion.
            self.alpha = 1.0
            }, completion: nil)
        
        
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
