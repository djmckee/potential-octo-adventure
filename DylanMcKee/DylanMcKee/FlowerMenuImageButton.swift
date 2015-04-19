//
//  FlowerMenuImageButton.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

class FlowerMenuImageButton: FlowerMenuRoundedButton {
   
    // an initialiser
    init(frame: CGRect, image: UIImage) {
        // call relevant super
        super.init(frame: frame)

        // draw image view that's as big as the current bounds.
        let imageView:UIImageView = UIImageView(frame: bounds)
        
        // set image
        imageView.image = image
        
        // add to view
        self.addSubview(imageView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
