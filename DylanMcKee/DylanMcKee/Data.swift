//
//  Data.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import Foundation
import UIKit

// A data handler class, full of class only methods, that reads data in from the data.json file in the app bundle
class Data {
    
    private class func getData() -> NSDictionary {
        // get an NSDictionary from the data.json file
        let filePath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        let data = NSData(contentsOfFile: filePath!)
        
        let jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
        
        println("jsonData: " + jsonData.description)
        
        return jsonData

    }
    
    // a convenience function to turn a dictionary of <String, AnyObject>'s into a FeatureItem
    private class func featureItemFromDict(dict :Dictionary<String,AnyObject>) -> FeatureItem {
        let title:String = dict["title"] as! String
        let desc:String = dict["description"] as! String
        
        let imageNamesArray:Array<String> = dict["images"] as! Array<String>
        
        var imagesArray = Array<UIImage>()
        
        for name in imageNamesArray {
            let image = UIImage(named: name)
            imagesArray.append(image!)
        }
        
        return FeatureItem(title: title, description: desc, images: imagesArray)
    }
    
    // return an array of strings to display in the menu...
    class func getMenuItemStrings() -> Array<String> {
        return getData().objectForKey("menu_items") as! Array<String>
    }
    
    // return a FeatureItem containing the 'About Me' data
    class func getAboutInfo() -> FeatureItem {
        let itemDict = getData().objectForKey("about_me") as! Dictionary<String, AnyObject>
        
        return featureItemFromDict(itemDict)
    }
    
    // return a FeatureItem containing the Education section data
    class func getEducationInfo() -> FeatureItem {
        let itemDict = getData().objectForKey("education") as! Dictionary<String, AnyObject>
        
        return featureItemFromDict(itemDict)
    }
    
}