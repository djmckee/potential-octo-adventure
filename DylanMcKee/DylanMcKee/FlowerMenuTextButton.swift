//
//  FlowerMenuTextButton.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

// a protocol to handle button taps
protocol FlowerMenuTextButtonDelegate {
    func flowerMenuTextButtonTapped(button :FlowerMenuTextButton)
}

class FlowerMenuTextButton: FlowerMenuRoundedButton {
    
    // a variable to hold the text value of the label
    var text:String?
    
    // an optional delegate for tapping callbacks
    var delegate:FlowerMenuTextButtonDelegate?
    
    // the current highlighted state, to be accessed through the getter/setter methods by external classes. Initialise to false because buttons are never highligted on creation.
    private var highlighted:Bool = false
    
    // should we count taps? only if the center button isn't sliding...
    private var shouldBeTappable = true
    
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
        
        label.minimumScaleFactor = 0.5
        
        // add to view
        self.addSubview(label)
        
        // add a tap gesture recognizer so we can recognize taps...
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("buttonTapped"))
        
        // we only need 1 tap
        tapGesture.numberOfTapsRequired = 1
        
        // start listening out for taps
        addGestureRecognizer(tapGesture)
        
        // observe menu center button movements - buttons shouldn't be tappable during sliding
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCenterStartedSliding:", name:FlowerMenuView.CenterButtonBeganSliding, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCenterFinishedSliding:", name:FlowerMenuView.CenterButtonBeganSliding, object: nil)
        
        
    }
    
    func buttonTapped() {
        // this is called by the tap gesture recognizer when we're tapped on - call relevant delegate methods...
        //println(text! + " tapped")
        
        delegate?.flowerMenuTextButtonTapped(self)
        
        // highlight ourselves briefly
        setHighlighted(true)
        
        // set a timer to unhighlight after 0.25 seconds
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: Selector("unhighlight"), userInfo: nil, repeats: false)
    }
    
    // a conveneince function to un-highlight the button from a timer - marked @objc so it can be private yet called by NSTimer
    func unhighlight() {
        // unhighlight ourselves.
        setHighlighted(false)
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
    
    // respond to flower menu center button notifications properly...
    func menuCenterStartedSliding(notification: NSNotification){
        // don't be tappable whilst the center button's sliding!
        shouldBeTappable = false
    }
    
    func menuCenterFinishedSliding(notification: NSNotification){
        // become tappable again once sliding's done.
        shouldBeTappable = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
