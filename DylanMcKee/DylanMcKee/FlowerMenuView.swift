//
//  FlowerMenuView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 17/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
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
    
    init(frame: CGRect, buttonNames: [String], middleButtonImage: UIImage) {
        // call super
        super.init(frame: frame)
        
        // check buttonNames has the 6 required items!
        if buttonNames.count != 6 {
            NSException(name: "Invalid arguments in FlowerMenuView Initialiser", reason: "Exactly 6 button name strings are required!", userInfo: nil)
            
        }
        
        
        // calculate button size and spacing in proprtion to the frame width (on a 320px wide display, they're 90px and 10px respectively)
        let buttonWidth:CGFloat = ((frame.size.width / 320.0) * 90.0)
        let buttonSpacing:CGFloat = ((frame.size.width / 320.0) * 10.0)
        
        // calculate top, middle, and bottom row x and y positions (these were created from the paper diagram, but seem to work).
        let entireButtonSize:CGFloat = (buttonWidth + buttonSpacing)
        let halfButtonSize:CGFloat = ((buttonWidth / 2) + (buttonSpacing / 2))
        let innerXRight:CGFloat = (self.center.x + halfButtonSize)
        let outerXRight:CGFloat = (self.center.y + entireButtonSize)
        let innerXLeft:CGFloat = (self.center.x - halfButtonSize)
        let outerXLeft:CGFloat = (self.center.y - entireButtonSize)
        let topY:CGFloat = (self.center.y + entireButtonSize)
        let midY:CGFloat = self.center.y
        let bottomY:CGFloat = (self.center.y - entireButtonSize)
        
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
            var buttonFrame = CGRectMake(x, y, buttonWidth, buttonWidth)
            
            // get title from array (WILL be there, since bounds checking's been done previously).
            var buttonTitle:String = buttonNames[i]
            
            // initialise our button
            
            // add to array so we can keep a reference of it conveniently
            
            // and add to frame
        }
        
        
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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
}
