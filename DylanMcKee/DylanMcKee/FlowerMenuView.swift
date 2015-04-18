//
//  FlowerMenuView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 17/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

// A menu that draws a central selector button, and 6 outside buttons to be selected. Provides appropriate callback delegate protocol. There's quite a lot of maths behind this that was done quickly on pen and paper, but it seems to work.
import UIKit

// callback delegate protocol
protocol FlowerMenuDelegate {
    func flowerMenuSectionSelectedWithName(name:String)
}

class FlowerMenuView: UIView {
    
    // a delegate, which must implement our FlowerMenuDelegate protocol, for callbacks when menu items are selected!
    var delegate:protocol<FlowerMenuDelegate>?
    
    // an array to conveniently store references to our buttons in
    var buttonArray:Array<FlowerMenuTextButton> = Array()
    
    // a conveneience reference to our main central button (of which there's only one)
    var centerButton:FlowerMenuImageButton?
    
    // a placeholder to hold the initial frame of the center button to save it being re-calculated.
    var centerButtonFrame:CGRect?
    
    // a boolean to indicate wheter or not we're currently dragging the center button around - defaulted to false for obvious reasons (we're not gonna be dragging on init).
    var draggingCenter:Bool = false
    
    init(frame: CGRect, buttonNames: [String], middleButtonImage: UIImage) {
        // call super
        super.init(frame: frame)
        
        // check buttonNames has the 6 required items!
        if buttonNames.count != 6 {
            NSException(name: "Invalid arguments in FlowerMenuView Initialiser", reason: "Exactly 6 button name strings are required!", userInfo: nil)
            
        }
        
        
        // calculate button size and spacing in proprtion to the frame width (on a 320px wide display, they're 90px and 10px respectively)
        let scaleFactor:CGFloat = (frame.size.width / 320.0)
        let buttonWidth:CGFloat = (scaleFactor * 90.0)
        let buttonSpacing:CGFloat = (scaleFactor * 10.0)
        
        // calculate top, middle, and bottom row x and y positions (these were created from the paper diagram, but seem to work).
        let midY:CGFloat = self.center.y
        let midX:CGFloat = self.center.x
        let entireButtonSize:CGFloat = (buttonWidth + buttonSpacing)
        let halfButtonSize:CGFloat = ((buttonWidth / 2) + (buttonSpacing / 2))
        let innerXRight:CGFloat = (midX + halfButtonSize)
        let outerXRight:CGFloat = (midX + entireButtonSize)
        let innerXLeft:CGFloat = (midX - halfButtonSize)
        let outerXLeft:CGFloat = (midX - entireButtonSize)
        let topY:CGFloat = (midY + entireButtonSize)
        let bottomY:CGFloat = (midY - entireButtonSize)
        
        // loop 6 times, so we can create each outer 'flower'.
        for i in 0...5 {
            // work out which x and y coordinates we want based upon the iteration number (starting top left).
            // (two switch statements used deliberatly to cut down code duplication).
            // decide x...
            var x:CGFloat
            switch (i) {
                case 0, 4:
                    x = innerXLeft
                
                case 1, 5:
                    x = innerXRight
                
                case 2:
                    x = outerXLeft
                
                case 3:
                    x = outerXRight
                
                default:
                    // should never be hit but just to keep Swift happy...
                    x = innerXLeft
                
            }
            
            // decide y...
            var y:CGFloat
            switch (i) {
                case 0, 1:
                    y = topY
                
                case 2, 3:
                    y = midY
                
                case 4, 5:
                    y = bottomY
                
                default:
                    // should never be hit but just to keep Swift happy...
                    y = topY
            }
            
            // initialise a frame for the button based off what the switch statement has decided for X and Y coordinates.
            // subtract the extra half button size's necessary to make these genuine x and y origin coordinates - rather than simply center coordinates (like what we've calculated so far!)
            var buttonFrame = CGRectMake((x - buttonWidth / 2), (y - buttonWidth/2), buttonWidth, buttonWidth)
            
            // get title from array (WILL be there, since bounds checking's been done previously).
            var buttonTitle:String = buttonNames[i]
            
            // initialise our button with the computed frame and the relevant title, and the current size scale factor, so that it can scale text up to make the most of whatever size display we're running on at the moment.
            var newButton:FlowerMenuTextButton = FlowerMenuTextButton(frame: buttonFrame, text: buttonTitle, scaleFactor: scaleFactor)
            
            // add to array so we can keep a reference of it conveniently
            buttonArray.append(newButton)

            // and add to frame
            addSubview(newButton)
        }
        
        // compute center button frame
        centerButtonFrame = CGRectMake((midX - buttonWidth/2), (midY - buttonWidth/2), buttonWidth, buttonWidth)
        
        // now draw the center button
        centerButton = FlowerMenuImageButton(frame: centerButtonFrame!, image: middleButtonImage)
        
        // and add to view
        addSubview(centerButton!)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // not gonna implement this in this implementation.
        NSException(name: "Not implemented", reason: "FlowerMenuView does not implement this method. Please check the implementation for details.", userInfo: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // not gonna implement this in this implementation - just stick to init with a frame parameter!
        NSException(name: "Not implemented", reason: "FlowerMenuView does not implement init with a coder parameter. Use init with a frame parameter instead!", userInfo: nil)
    }
    
    // allow dragging of the centreButton ONLY by touchesBegan, touchesMoved, touchesEnded UIView methods being implemented
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        //println("touchesBegan: " + touch.description)
        
        checkIfTouchIsInsideAndMove(touch)

    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        //println("touchesMoved: " + touch.description)
        
        checkIfTouchIsInsideAndMove(touch)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        //println("touchesEnded: " + touch.description)
        
        // see if the user finished up inside of any of the menu items, then call the delegate method if they did
        
        // 'ping' the center head back to the middle - DO NOT LEAVE STUFF FLOATING
        returnHeadToMiddle()
    }
    
    // a conveneince function that checks if the touch passed to it is inside of the center button, and if so moves the center button's center to the touch's location
    private func checkIfTouchIsInsideAndMove(touch :UITouch) {
        let location = touch.locationInView(self)
        let frame = centerButton?.frame
        
        if CGRectContainsPoint(frame!, location) {
            // it's inside the center button! Move the center button's center to the touch's center...
            moveCenterButtonToLocation(location)
            
            // and highlight buttons that we may have moved inside of/unhighlight buttons we've moved out of...
            highlightButtonsIfInside(location)
        }
    }
    
    // check if the center of the center button is intersecting any of the
    private func highlightButtonsIfInside(location :CGPoint) {
        // iterate through the buttons array...
        for b:FlowerMenuTextButton in buttonArray {
            if CGRectContainsPoint(b.frame, location) {
                // highlight!
                b.setHighlighted(true)
            } else {
                // unhighlight!
                b.setHighlighted(false)
            }
        }
        
    }
    
    private func moveCenterButtonToLocation(location :CGPoint) {
        // move the center button's center to the specified CGPoint
        centerButton?.center = location
    }
    
    
    private func returnHeadToMiddle() {
        // a private convenience method to reset the centerButton back to the middle of the view (its initial position) in an animated fashion.
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            centerButton?.frame = centerButtonFrame!
        })
        
        // check what's highlighted - find the highlighted button, make it un-highligted, and call the delegate (if present) with it's title...
        for b:FlowerMenuTextButton in buttonArray {
            if b.isHighlighted() {
                // the user's selected this option!
                // unhighlight...
                b.setHighlighted(false)
                
                // and call the delegate, passing in its title...
                delegate?.flowerMenuSectionSelectedWithName(b.text!)
                
            }
        }
        
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
