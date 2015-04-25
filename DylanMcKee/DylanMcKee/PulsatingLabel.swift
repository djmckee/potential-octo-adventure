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
        self.font = UIFont(name: Constants.lightFontName, size: Constants.mediumLabelFontSize)
        
        // set a white font colour
        self.textColor = UIColor.whiteColor()
                
        self.alpha = 0.5
        
        // begin animating ourselves, constantly.
        UIView.animateKeyframesWithDuration(1.5, delay: 2.0, options: (UIViewKeyframeAnimationOptions.Repeat | UIViewKeyframeAnimationOptions.Autoreverse), animations: { () -> Void in
            // fade in (remember this will be reversed thanks to the view animation options to turn into a fade out)
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
