//
//  ProjectItem.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 19/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//

import Foundation
import UIKit

// a ProjectItem is a FeatureItem subclass, with a subtitle field added.

class ProjectItem : FeatureItem {
    var subtitle:String!
    
    init(title:String, subtitle: String, description:String, images:Array<UIImage>){
        // call the super init, passing in what we've been passed
        super.init(title: title, description: description, images: images)
        
        // set the subtitle variable in too
        self.subtitle = subtitle
        
    }
    
    // a factory style constructor to simply turn FeatureItems into ProjectItems (because we can't downcast directly!)
    class func initWithFeatureItemAndSubtitle(featureItem: FeatureItem, subtitle: String) -> ProjectItem {
        return ProjectItem(title: featureItem.title!, subtitle: subtitle, description: featureItem.description!, images: featureItem.images)
    }
    
}