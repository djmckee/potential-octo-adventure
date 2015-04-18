//
//  MainViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 14/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit
import MediaPlayer

class MainViewController: UIViewController, UIScrollViewDelegate, FlowerMenuDelegate {
    
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var instructionalLabel:UILabel!
    
    // initialView and menuView will be created and managed programatically, not using the storyboard, from their relevant subclasses and respective NIBs.
    var initialView:InitialView!
    var menuView:MainMenuView!
    
    var firstScrollViewPaneFrame:CGRect!
    var secondScrollViewPaneFrame:CGRect!
    
    // a boolean to indicate that the scrollView has been setup (to stop permenant affixing to the first pane due to delegate values being called before programatic scrolling has taken place properly)
    var initialScrollSetup:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // scrolling should be swift and merciless
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        
        // set scroll view content size to be same height as the view, but twice the width (for lock screen style sliding)
        scrollView.contentSize = CGSizeMake((self.view.bounds.size.width * 2.0), self.view.bounds.size.height)

        // calculate the scroll view 'pane' frames...
        firstScrollViewPaneFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        secondScrollViewPaneFrame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)
        
        
        // initialise the initialView,
        initialView = InitialView(frame: secondScrollViewPaneFrame)
                    
        // add initial view to the scrollView
        scrollView.addSubview(initialView)
        
        // initialise the menuView...
        menuView = MainMenuView(frame: firstScrollViewPaneFrame)
        
        // set ourselves as a delegate to the menu view's menu...
        menuView.menu?.delegate = self
        
        // and add to the scrollView
        scrollView.addSubview(menuView)
        
        // UIScrollView doesn't like programatically scrolling straight away, do it after a very short delay...
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("scrollToSecond"), userInfo: nil, repeats: false)

        
    }
    
    func scrollToSecond(){
        // and programatically zoom the scrollview to the 'initial' view so the user can 'unlock' the app by sliding left... (because this happens on launch it really shouldn't be animated)
        scrollView.scrollRectToVisible(secondScrollViewPaneFrame, animated: false)
        
        
        // okay, the scrollRectToVisible above has set-up the scrollview, make delegate aware...
        initialScrollSetup = true

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // if we're not set-up yet, don't take notice of this event
        if !initialScrollSetup {
            return;
        }
        
        // see if the scrolling was over 50% towards the first 'pane' - if so snap to the first pane, if not, snap back to the second 'pane' - we don't allow 'floating' half way between the two!
        
        println(scrollView.bounds)
        
        let halfwayPanePoint = scrollView.contentSize.width - (firstScrollViewPaneFrame.size.width)
        
        let currentScrollX = scrollView.bounds.origin.x
        
        // the alpha of the background image should be proportional to the amount that it is scrolled to the left pane - when fully in the left pane, alpha drops to 0.5, when fully in the right pane, alpha is at 1.0
        var computedAlpha:CGFloat
        
        computedAlpha = (currentScrollX / firstScrollViewPaneFrame.size.width)
        
        // has a minimum of 50% alpha - perform a bounds check!
        if computedAlpha < 0.5 {
            computedAlpha = 0.5
        }
        
        // set computed alpha
        backgroundImageView.alpha = computedAlpha
        
        
        if currentScrollX < halfwayPanePoint {
            // user is in first pane! snap to it
            println("in first pane!")
            // call relevant method to setup pane.
            initialiseFirstPane()

            
        } else {
            // snap back to the second pane!
            scrollView.scrollRectToVisible(secondScrollViewPaneFrame, animated: true)

        }
        
        
    }
    
    
    // a function to be called when the user scrolls into the first pane!
    private func initialiseFirstPane() {
        
        // sort out the instructional label first...
        // add rounded corners!
        instructionalLabel.layer.masksToBounds = true
        instructionalLabel.layer.cornerRadius = 5.0
        
        // show the instructional label for 7 seconds
        instructionalLabel.hidden = false
        
        NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: Selector("hideIntroLabel"), userInfo: nil, repeats: false)
        
        
        // jump completely into first pane (with animation).
        scrollView.scrollRectToVisible(firstScrollViewPaneFrame, animated: true)
        
        // stop the scrollview scrolling again (user can only 'unlock' the app once!)
        scrollView.scrollEnabled = false
    }
    
    
    func hideIntroLabel() {
        // hide the instructional intro label in a smooth fade animation
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.instructionalLabel.alpha = 0.0
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // flower menu delegate implementation...
    func flowerMenuSectionSelectedWithName(name:String) {
        println("clicked on " + name)
        
        if name == "intro" {
            // play intro video.
            playIntroVideo()
        }
        
    }

    
    func playIntroVideo() {
        // play intro.m4v.
        
        // load the file path in...
        let videoFilePath = NSBundle.mainBundle().pathForResource("intro", ofType: "m4v")
        let videoPathUrl = NSURL.fileURLWithPath(videoFilePath!)
        
        // instantiate a player, passing in the local URL to our video file
        let videoPlayer = MPMoviePlayerViewController(contentURL: videoPathUrl)
        
        // and present the player modally over the view...
        presentMoviePlayerViewControllerAnimated(videoPlayer)
    }
    
    // this view controller should be portrait only!
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}

