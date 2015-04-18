//
//  FlowerMenuTextButton.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class FlowerMenuTextButton: FlowerMenuRoundedButton {
    
    // a variable to hold the text value of the label
    var text:String?
    
    // the current highlighted state, to be accessed through the getter/setter methods by external classes. Initialise to false because buttons are never highligted on creation.
    private var highlighted:Bool = false
    
    // an initialiser
    init(frame: CGRect, text: String, scaleFactor: CGFloat) {
        // call relevant super
        super.init(frame: frame)
        
        // set up variable
        self.text = text
        
        // draw label that's as big as the current frame.
        let label:UILabel = UILabel(frame: bounds)
        
        let baseFontSize:CGFloat = 19.0
        
        // calculate font size to scale (multiplying the base font size by the scale factor for this display that we've been passed)
        let fontSize = (baseFontSize * scaleFactor)
        
        // set font
        label.font = UIFont(name: "HelveticaNeue-Light", size: fontSize)
        
        // center text
        label.textAlignment = NSTextAlignment.Center
        
        // give us an almost white (flat off-white) label
        label.textColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        
        // set text
        label.text = self.text
        
        // add to view
        self.addSubview(label)
        
    }
    
    // highlighted state needs a getter and setter method pair. The setter must highlight the button depending on what it's been passed!
    func setHighlighted(highlighted :Bool) {
        if highlighted {
            // make it so. Change background to an off white
            self.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.4)

        } else {
            // clear any highlighting by using a clear background again.
            self.backgroundColor = UIColor.clearColor()
        }
        
        // and set boolean
        self.highlighted = highlighted
    }
    
    // return highlighted state
    func isHighlighted() -> Bool {
        return highlighted
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
