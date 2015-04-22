//
//  ImageCollectionViewCell.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    
    private func commonInit() {
        imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()

    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // add a little off white border to it all
        self.layer.borderWidth = 1.0
        self.layer.borderColor = Constants.offWhiteBorderColor.CGColor
        
    }
    
}
