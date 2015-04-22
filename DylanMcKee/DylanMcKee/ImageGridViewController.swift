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
    
    // an array of FeatureItems do display - public so it can be set when pushing from other view controllers.
    var itemsList:Array<FeatureItem>!
    
    // re-use identifier constant
    private let reuseIdentifier:String = "imageGridCell"
    
    // a placeholder to hold teh selected FeatureItem in between item selection and the prepareForSegue method
    private var selectedItem:FeatureItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        collectionView.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return itemsList.count;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
                
        // get the item for the current indexPath...
        let currentItem:FeatureItem = itemsList[indexPath.row]
        
        // set the image to the featured image for the current item.
        cell.imageView.image = currentItem.featuredImage
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        //println("selected " + String(indexPath.row))
        
        // get the selected item and set the placeholder so it can be set properly in prepareForSegue
        selectedItem = itemsList[indexPath.row]
        
        // perform the segue to the detail view
        performSegueWithIdentifier("imageGridDetailView", sender: nil)

        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // set the selectedItem data property...
        var nextViewController = segue.destinationViewController as! FeatureViewController
        nextViewController.data = selectedItem
        
    }
    
}
