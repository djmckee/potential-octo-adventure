//
//  MainViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 14/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit
import MediaPlayer

// types for view controllers in a neat enum (only required for view controllers where one class is used for two types of controller).
enum ViewControllerTypes {
    case AboutViewController
    case InterestsViewController
    case EducationViewController
    case AchievementViewController
    
}

class MainViewController: UIViewController, UIScrollViewDelegate, FlowerMenuDelegate {
    
    
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet weak var instructionalLabel:UILabel!
    
    // initialView and menuView will be created and managed programatically, not using the storyboard, from their relevant subclasses and respective NIBs.
    private var initialView:InitialView!
    private var menuView:MainMenuView!
    
    private var firstScrollViewPaneFrame:CGRect!
    private var secondScrollViewPaneFrame:CGRect!
    
    // a boolean to indicate that the scrollView has been setup (to stop permenant affixing to the first pane due to delegate values being called before programatic scrolling has taken place properly)
    private var initialScrollSetup:Bool = false
    
    // a placeholder to hold the type of view controller being pushed next, so we can prepare proprely in prepareForSegue
    private var nextViewControllerTypeToPush:ViewControllerTypes?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Style the nav bar so it looks presentable when shown on relevant view controllers....
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 22)!]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
        
        
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
        let middleImage:UIImage = UIImage(named: "DylanHead")!

        menuView = MainMenuView(frame: firstScrollViewPaneFrame, menuItems: Data.getMenuItemStrings(), centerImage: middleImage)
        
        // set ourselves as a delegate to the menu view's menu...
        menuView.menu?.delegate = self
        
        // and add to the scrollView
        scrollView.addSubview(menuView)
        
        // observe menu center button movements...
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCenterStartedSliding:", name:FlowerMenuView.CenterButtonBeganSliding, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuCenterFinishedSliding:", name:FlowerMenuView.CenterButtonBeganSliding, object: nil)
        
        // UIScrollView doesn't like programatically scrolling straight away, do it after a very short delay...
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("scrollToSecond"), userInfo: nil, repeats: false)

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // absolutely do not want a nav bar under any circuimstances.
        self.navigationController?.navigationBarHidden = true
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
     
        
        
        let currentScrollX = scrollView.bounds.origin.x
        
        // the alpha of the background image should be proportional to the amount that it is scrolled to the left pane - when fully in the left pane, alpha drops to 0.3, when fully in the right pane, alpha is at 1.0
        var computedAlpha:CGFloat
        
        computedAlpha = (currentScrollX / firstScrollViewPaneFrame.size.width)
        
        // has a minimum of 30% alpha - perform a bounds check!
        let minimumAlphaLimit:CGFloat = 0.3
        if computedAlpha < minimumAlphaLimit {
            computedAlpha = minimumAlphaLimit
        }
        
        // set computed alpha
        backgroundImageView.alpha = computedAlpha
        
        if scrollView.contentOffset.x < 5 && instructionalLabel.hidden == true {
            // if the scrollView's been scrolled right to the start, and the instructionalLabel hasn't yet been shown, show it to the user so they know what to do!
            showInstructionalLabel()
        }
        
    }
    
    
    // a function to show the instruction label for 5 seconds then fade it out.
    private func showInstructionalLabel() {
        
        // sort out the instructional label first...
        // add rounded corners!
        instructionalLabel.layer.masksToBounds = true
        instructionalLabel.layer.cornerRadius = 5.0
        
        // show the instructional label for a few seconds
        self.instructionalLabel.hidden = false

        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.instructionalLabel.alpha = 1.0
        })
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("hideIntroLabel"), userInfo: nil, repeats: false)

    }
    
    
    func hideIntroLabel() {
        // hide the instructional intro label in a smooth fade animation
        UIView.animateWithDuration(0.5, animations: { () -> Void in
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
        
        if name == "interests" {
            nextViewControllerTypeToPush = ViewControllerTypes.InterestsViewController
            performSegueWithIdentifier("showImageGrid", sender: nil)
        }
        
        if name == "achievements" {
            nextViewControllerTypeToPush = ViewControllerTypes.AchievementViewController
            performSegueWithIdentifier("showImageGrid", sender: nil)
        }
        
        if name == "about me" {
            nextViewControllerTypeToPush = ViewControllerTypes.AboutViewController
            performSegueWithIdentifier("showDetailView", sender: nil)
        }
        
        if name == "education" {
            nextViewControllerTypeToPush = ViewControllerTypes.EducationViewController
            performSegueWithIdentifier("showDetailView", sender: nil)
        }
        
        if name == "projects" {
            performSegueWithIdentifier("showProjects", sender: nil)
        }
        
    }
    
    // respond to flower menu center button notifications properly...
    func menuCenterStartedSliding(notification: NSNotification){
        // disable the scrollview's scrolling!
        scrollView.scrollEnabled = false
    }
    
    func menuCenterFinishedSliding(notification: NSNotification){
        // enable the scrollview's scrolling!
        scrollView.scrollEnabled = true
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showImageGrid" {
            var nextViewController = segue.destinationViewController as! ImageGridViewController
            
            if nextViewControllerTypeToPush == ViewControllerTypes.InterestsViewController {
                // push for interests
                nextViewController.itemsList = Data.getInterests()
                nextViewController.title = "Interests"
                
            } else if nextViewControllerTypeToPush == ViewControllerTypes.AchievementViewController {
                // push for achievements
                nextViewController.itemsList = Data.getAchievements()
                nextViewController.title = "Achievements"
            }
        }
        
        if segue.identifier == "showDetailView" {
            var nextViewController = segue.destinationViewController as! FeatureViewController
            
            if nextViewControllerTypeToPush == ViewControllerTypes.AboutViewController {
                // push for about me
                nextViewController.data = Data.getAboutInfo()
                nextViewController.title = "About Me"
                
            } else if nextViewControllerTypeToPush == ViewControllerTypes.EducationViewController {
                // push for education
                nextViewController.data = Data.getEducationInfo()
                nextViewController.title = "Education"
            }
        }
        
    }
    

    private func playIntroVideo() {
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

