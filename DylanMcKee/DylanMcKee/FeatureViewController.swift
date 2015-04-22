//
//  FeatureViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//

import UIKit
import MediaPlayer

class FeatureViewController: UIViewController, UIScrollViewDelegate, UITextViewDelegate {
    
    // a placeholder FeatureItem that the data will be loaded in from and displayed in this ViewController... a public variable so it can be set from other view controller's prepareForSegue methods.
    var data:FeatureItem!
    
    // a scroll view that allows vertical scrolling and contains everything.
    var containerScrollView:UIScrollView!
    
    // a scroll view to hold our many images
    var imageScrollView:UIScrollView!
    
    // page control component
    var pageControl:UIPageControl!
    
    // a textview to hold the description
    var descriptionTextView:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This view controller requires a text view with dynamic height inside of a scrollview, and autolayout doesn't quite cut it for dynamic content - so I'm drawing views programatically in code instead.
        let imageScrollViewHeight:CGFloat = CGFloat(320);
        containerScrollView = UIScrollView(frame: self.view.frame)
        
        view.addSubview(containerScrollView)
        
        imageScrollView = UIScrollView(frame: CGRectMake(0, 0, containerScrollView.frame.size.width, imageScrollViewHeight))
        imageScrollView.delegate = self
        imageScrollView.pagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        
        containerScrollView.addSubview(imageScrollView)
        
        pageControl = UIPageControl(frame: CGRectMake(0, imageScrollViewHeight, containerScrollView.frame.size.width, 37))
        
        // add value changed callback!
        pageControl.addTarget(self, action: Selector("pageControlChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        containerScrollView.addSubview(pageControl)
        
        descriptionTextView = UITextView()
        
        // don't let people edit!
        descriptionTextView.editable = false
        
        //set colours
        descriptionTextView.backgroundColor = UIColor.clearColor()
        descriptionTextView.textColor = UIColor.whiteColor()
        
        // don't let people scroll - it's going inside of a scrollview, this would cause serious issues.
        descriptionTextView.scrollEnabled = false
        
        // set delegate to self to handle link clicks.
        descriptionTextView.delegate = self
        
        containerScrollView.addSubview(descriptionTextView)
        
        // set the title to the FeatureItem's title
        self.title = data.title
        
        // set scrollview content size to the number of images we have to display multiplied by the width of the scrollview currently
        let totalScrollWidth:CGFloat = (self.view.frame.size.width * CGFloat(data.images.count))
        
        // set to calculated size.
        imageScrollView.contentSize = CGSizeMake(totalScrollWidth, imageScrollView.frame.size.height)
        
        // lock direction 
        imageScrollView.directionalLockEnabled = true
        
        // iterate through the images, creating a UIImageView for each one, adding the image to it, and adding it to the relevant frame iside of the imageScrollView
        var counter = 0
        
        for image:UIImage in data.images {
            let newXPosition:CGFloat = (self.view.frame.size.width * CGFloat(counter))
            let newImageView:UIImageView = UIImageView(image: image)
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

        // scroll to initial rect.
        imageScrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
        
        // extract hyperlinks from the description string...
        let rawDescriptionString:String = data.description!
        
        // initialise a mutable attributed string so we can add links (if necessary) and modify it safely... (declared as a var so we can use NSString's built in replace methods).
        var attributedDescriptionString:NSMutableAttributedString = NSMutableAttributedString(string: rawDescriptionString)
        
        // whilst the string contains HTML-esque link tags (<a href...), loop through them...
        // define the link start/end of start/end of link tags as constants for future schema changes.
        let linkStartSchema:String = "<a href=\""
        let linkStartEnd:String = "\">"
        let linkEndSchema:String = "</a>"
        
        // generically style the entire string...
        // Style attributed string and links too!
        // start string editing.
        attributedDescriptionString.beginEditing()
        
        // now style the attributed body text...
        let entireString = NSMakeRange(0, attributedDescriptionString.length)
        let bodyFont = UIFont(name: "HelveticaNeue-Light", size: 18)
        attributedDescriptionString.addAttribute(NSFontAttributeName, value: bodyFont!, range: entireString)
        
        attributedDescriptionString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: entireString)
        
        
        // finish up editing
        attributedDescriptionString.endEditing()
        
        // while there's still link start schema's in the string, keep looping to extract them...
        // while there's still link start schema's in the string, keep looping to extract them...
        while attributedDescriptionString.string.contains(linkStartSchema) {
            // okay, there's a link for us to link up...
            
            // use a scanner to extract the start of the start tag...
            var scanner:NSScanner = NSScanner(string: attributedDescriptionString.string)
            
            // create a blank placeholder string that we can scan into safely...
            var scannedString:NSString?
            
            // find out where the opening link tag starts.
            scanner.scanUpToString(linkStartSchema, intoString: &scannedString)
            let linksStartLocation = scanner.scanLocation
            
            // find out where the opening link tag ends.
            scanner.scanUpToString(linkStartEnd, intoString: &scannedString)
            let linksEndLocation = scanner.scanLocation
            
            // extract the link from the String, removing potential link element schema that's contaminating it...
            let link = scannedString?.stringByReplacingOccurrencesOfString(linkStartSchema, withString: "")
            
            let rangeOfLinkOpeningTag = NSMakeRange(linksStartLocation, (linksEndLocation - linksStartLocation))
            
            // scan up to the end of the start tag so that we can get the location
            scanner.scanUpToString(linkEndSchema, intoString: &scannedString)
            var linkEndTagLocation = scanner.scanLocation
            
            // work out where we need to link within the string (i.e. the actual linked text range), so that we can then apply the link attribute
            let rangeOfTextToLink = NSMakeRange(rangeOfLinkOpeningTag.location, (linkEndTagLocation - rangeOfLinkOpeningTag.location))
            
            // add link in the NSMutableAttributedString...
            // and link styling within the text (by making them bold(er))
            let linkFont = UIFont(name: "HelveticaNeue-Medium", size: bodyFont!.pointSize)
        
            
            // start string editing.
            attributedDescriptionString.beginEditing()
            
            // add link to relevant range
            attributedDescriptionString.addAttribute(NSLinkAttributeName, value: NSURL(string: link!)!, range: rangeOfTextToLink)
            
            // make link in link text style
            attributedDescriptionString.addAttribute(NSFontAttributeName, value: linkFont!, range: rangeOfTextToLink)

            // finish up editing
            attributedDescriptionString.endEditing()
            
            
            // remove opening link tag...
            let rangeOfEntireOpeningTag = NSMakeRange(rangeOfLinkOpeningTag.location, (rangeOfLinkOpeningTag.length + count(linkStartEnd)))
            
            // replace opening tag with a blank
            attributedDescriptionString.replaceCharactersInRange(rangeOfEntireOpeningTag, withString: "")
            
            // string length has changed - we're gonna need a re-scan to compute the link end tag location again...
            // reset scanner to a new scanner with the changed string...
            scanner = NSScanner(string: attributedDescriptionString.string)
            
            // scan up to the link end into a string so we can see where it ends in the new changed string
            scanner.scanUpToString(linkEndSchema, intoString: &scannedString)
            linkEndTagLocation = scanner.scanLocation
            
            // remove end tag by making a range from it's start location + it's length, then replacing this range wiht a blank string
            let rangeOfEndTag = NSMakeRange(linkEndTagLocation, count(linkEndSchema))
            
            // replace with a blank...
            attributedDescriptionString.replaceCharactersInRange(rangeOfEndTag, withString: "")
            
            // now that we've removed the link string within our string, and linked up the attributed string properly, we can safely continue on in the loop knowing that there's no chance of infinity! Carry on looping if possible...
            
        }
        
        // calculate descriptionTextView size and set its frame based upon the string length!
        // make max size have a width of the current view minus a little padding, and a pretty much infinite-ish height.
        let maxSize = CGSizeMake((containerScrollView.frame.size.width - 20), 90000.0)
        
        // calculate based upon max size and upon the text view's font setup
        let textRect = attributedDescriptionString.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin
            , context: nil)
        
        // create a suitable rect using the textRect sizes for the descriptionTextView... (with some added padding)
        descriptionTextView.frame = CGRectMake(0, (imageScrollViewHeight + pageControl.frame.size.height), containerScrollView.frame.size.width, (textRect.size.height + 30))

        // now set our attributed string to be displayed in the description text view, now that we've added any links...
        descriptionTextView.attributedText = attributedDescriptionString
        
        // set a link colour for the textview
        descriptionTextView.linkTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // now set our container scroll view's content size to fit the descriptionTextView in properly...
        containerScrollView.contentSize = CGSizeMake(containerScrollView.frame.size.width, (descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height + 30.0))

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // we want a navbar
        self.navigationController?.navigationBarHidden = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Page control value changed
    func pageControlChanged(sender: AnyObject) -> () {
        // calculate the scroll position by multiplying current page number by the width of 1 scroll piece...
        let scrollPosition = (CGFloat(pageControl.currentPage) * (self.view.frame.size.width))
        
        // and scroll the scroll view to the desired position...
        imageScrollView.setContentOffset(CGPointMake(scrollPosition, 0), animated: true)
        
    }
    
    // Scroll view delegate
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) -> () {
        // if it's not the image scroll view, return, we're not interested.
        if scrollView != imageScrollView {
            return;
        }
        
        // round down to get the current page
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        // set page control's current page to what we've scrolled to...
        pageControl.currentPage = Int(currentPage)
    }
    
    // Text view delegate to intercept link clicks (so we can handle the custom 'video://name' schema...
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        println("clicked " + URL.description)
        
        // see if the custom video schema is in use...
        if URL.description.contains("video://") {
            // if it's video:// schema, play it
            let videoFileName = URL.description.stringByReplacingOccurrencesOfString("video://", withString: "", options: nil, range: nil)
            
            
            // play it via our convenience method
            playVideoWithName(videoFileName)
            
            // return false - we're handling this ourselves!
            return false
        }
        
        // go ahead and open it normally...
        return true
    }
    
    // a convenience function to play a video with the local file name passed in as a parameter...
    func playVideoWithName(name :String) {
        // load the file path in...
        let videoFilePath = NSBundle.mainBundle().pathForResource(name, ofType: "m4v")
        let videoPathUrl = NSURL.fileURLWithPath(videoFilePath!)
        
        // instantiate a player, passing in the local URL to our video file
        let videoPlayer = MPMoviePlayerViewController(contentURL: videoPathUrl)
        
        // and present the player modally over the view...
        presentMoviePlayerViewControllerAnimated(videoPlayer)
    }
    
}
