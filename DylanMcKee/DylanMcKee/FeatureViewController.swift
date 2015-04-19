//
//  FeatureViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController, UIScrollViewDelegate {
    
    // a placeholder FeatureItem that the data will be loaded in from and displayed in this ViewController...
    var data:FeatureItem!
    
    // a scroll view to hold our many images
    @IBOutlet weak var imageScrollView:UIScrollView!
    
    // page control component
    @IBOutlet weak var pageControl:UIPageControl!
    
    // a textview to hold the description
    @IBOutlet weak var descriptionTextView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // we want a navbar
        self.navigationController?.navigationBarHidden = false
        
        // set the title to the FeatureItem's title
        self.title = data.title
        
        // set scrollview content size to the number of images we have to display multiplied by the width of the scrollview currently
        let totalScrollWidth:CGFloat = (self.view.frame.size.width * CGFloat(data.images.count))
        
        // set to calculated size.
        imageScrollView.contentSize = CGSizeMake(totalScrollWidth, imageScrollView.frame.size.height)
        
        // iterate through the images, creating a UIImageView for each one, adding the image to it, and adding it to the relevant frame iside of the imageScrollView
        var counter = 0
        
        for image:UIImage in data.images {
            let newXPosition = (imageScrollView.frame.size.width * CGFloat(counter))
            let newImageView = UIImageView(image: image)
            newImageView.frame = CGRectMake(newXPosition, 0, self.view.frame.size.width, imageScrollView.frame.size.height)
            
            newImageView.contentMode = UIViewContentMode.ScaleAspectFill
            
            // clip to bounds!
            newImageView.clipsToBounds = true
            
            // add to the scroll...
            imageScrollView.addSubview(newImageView)
            
            counter++
        }
        
        // set the number of pages to the number of images.
        pageControl.numberOfPages = data.images.count

        // and set description text
        descriptionTextView.text = data.description

        // scroll to initial rect.
        imageScrollView.scrollRectToVisible(CGRectMake(0, 0, self.view.frame.size.width, imageScrollView.frame.size.height), animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Page control callback
    @IBAction func pageControlChanged(sender: AnyObject) -> () {
        // calculate the scroll position by multiplying current page number by the width of 1 scroll piece...
        let scrollPosition = (CGFloat(pageControl.currentPage) * (self.view.frame.size.width))
        
        // and scroll the scroll view to the desired position...
        imageScrollView.setContentOffset(CGPointMake(scrollPosition, 0), animated: true)
        
    }
    
    // Scroll view delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> () {
        
        // round down to get the current page
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        // set page control's current page to what we've scrolled to...
        pageControl.currentPage = Int(currentPage)
    }
    
    
    // this view controller should be portrait only!
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
}
