//
//  GridCollectionViewLayout.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 djmckee. All rights reserved.
//

import UIKit

class GridCollectionViewLayout: UICollectionViewFlowLayout {
    
    
    // a common init method allows safe initilisation programatically or from interface builder...
    private func commonInit() {
        // scroll veritcally
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        // give 10px of spacing
        self.minimumLineSpacing = 10.0
        self.minimumInteritemSpacing = 10.0
        
        // give items a 95px square
        self.itemSize = CGSizeMake(95.0, 95.0)
        
    }
    
    override init() {
        super.init()
        commonInit()
    }
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
}
