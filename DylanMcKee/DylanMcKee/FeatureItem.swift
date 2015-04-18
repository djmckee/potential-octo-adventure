//
//  FeatureItem.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

// A class to model a feature item - features a title string, description string, an array of images, and a computed property that conveneintly returns the first image in the images array
class FeatureItem {
    var title:String?
    
    var description:String?
    
    var images:Array<UIImage> = []
    
    var featuredImage:UIImage {
        if images.count > 0 {
            return images.first!
        } else {
            return UIImage()
        }
    }
    
    // a convenience constructor
    init(title:String, description:String, images:Array<UIImage>){
        self.title = title
    
        self.description = description
        
        self.images = images
        
    }
   
}
