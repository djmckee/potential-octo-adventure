//
//  MainMenuView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

// A UIView to sit on the left hand pane of the scrollView in MainViewController, containing a FlowerMenuView (and allowing for the pass through the FlowerMenuView delegate methods)
class MainMenuView: UIView {
    
    // making it a public instance variable so that it's accessible to the ViewController that calls this class (since we want the viewController to become the flower menu's delegate to handle button press events).
    var menu:FlowerMenuView?

    // using an intitialiser to pass through the menu values to provide a decent level of abstraction...
    init(frame: CGRect, menuItems: Array<String>, centerImage: UIImage) {
        // call super first
        super.init(frame: frame)
        
        // create an array of strings holding our 6 menu button names....
        var names:[String] = menuItems
        
        // this seems to end up in reverse order, so negate that with a quick call to reverse.
        names = names.reverse()
        
        // now initialise our flower menu
        menu = FlowerMenuView(frame: self.frame, buttonNames: names, middleButtonImage: centerImage)
        
        // and add to the view
        self.addSubview(menu!)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // not gonna implement this in this implementation - just stick to init with a frame parameter!
        fatalError("Not implemented. Please use initWithFrame instead!")
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
