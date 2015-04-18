//
//  MainMenuView.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

// A UIView to sit on the left hand pane of the scrollView in MainViewController, containing a FlowerMenuView (and allowing for the pass through the FlowerMenuView delegate methods)
class MainMenuView: UIView {
    
    // making it an instance variable so that it's accessible to the ViewController that calls this class (since we want the viewController to become the flower menu's delegate to handle button press events).
    var menu:FlowerMenuView?

    override init(frame: CGRect) {
        // call super first
        super.init(frame: frame)
        
        // create an array of strings holding our 6 menu button names....
        var names:[String] = ["about me", "intro", "projects", "interests", "education", "achievements"]
        
        // this seems to end up in reverse order, so negate that with a quick call to reverse.
        names = names.reverse()
        
        // get the middle button image initialised...
        let middleImage:UIImage = UIImage(named: "DylanHead")!
        
        // now initialise our flower menu
        menu = FlowerMenuView(frame: self.frame, buttonNames: names, middleButtonImage: middleImage)
        
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
