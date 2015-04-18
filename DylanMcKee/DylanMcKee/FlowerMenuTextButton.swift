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
    
    // an initialiser
    init(frame: CGRect, text: String) {
        // call relevant super
        super.init(frame: frame)
        
        // set up variable
        self.text = text
        
        // draw label that's as big as the current frame.
        let label:UILabel = UILabel(frame: bounds)
        
        // set font
        label.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        
        // center text
        label.textAlignment = NSTextAlignment.Center
        
        // give us an almost white (flat off-white) label
        label.textColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
        
        // set text
        label.text = self.text
        
        // add to view
        self.addSubview(label)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
