//
//  MainViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 14/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    // initialView and menuView will be created and managed programatically, not using the storyboard, from their relevant subclasses and respective NIBs.
    var initialView:UIView!
    var menuView:InitialView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set scroll view content size to be same height as the view, but twice the width (for lock screen style sliding)
        scrollView.contentSize = CGSizeMake((self.view.frame.size.width * 2.0), self.view.frame.size.height)

        // initialise the initialView,
        // set the 'initial' view's frame to the right hand side of the scroll view, with a width set to the current view size
        initialView = InitialView(frame: CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height))
            
        initialView.backgroundColor = UIColor.blueColor()
        
        // add initial view to the scrollView
        scrollView.addSubview(initialView)
        
        
        // and programatically zoom the scrollview to the 'initial' view so the user can 'unlock' the app by sliding left... (because this happens on launch it really shouldn't be animated)
        scrollView.scrollRectToVisible(initialView.frame, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

