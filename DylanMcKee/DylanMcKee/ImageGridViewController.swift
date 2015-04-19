//
//  ImageGridViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//

import UIKit

class ImageGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    // an array of FeatureItems do display
    var itemsList:Array<FeatureItem>!
    
    // re-use identifier constant
    let reuseIdentifier:String = "imageGridCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // we want a navbar
        self.navigationController?.navigationBarHidden = false
        
        
        // Do any additional setup after loading the view.
        collectionView.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return itemsList.count;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.backgroundColor = UIColor.redColor()
        
        // get the item for the current indexPath...
        let currentItem:FeatureItem = itemsList[indexPath.row]
        
        // set the image to the featured image for the current item.
        cell.imageView.image = currentItem.featuredImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        //println("selected " + String(indexPath.row))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    
    // this view controller should be portrait only!
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}
