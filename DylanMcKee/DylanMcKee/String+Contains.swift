//
//  String+Contains.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 22/04/2015.
//  Copyright (c) 2015 Dylan McKee. All rights reserved.
//  (I previously released this as a Gist on GitHub at https://gist.github.com/djmckee/f8fc4310b451122a47b8 - and used it in my Who Can I Vote For open source Swift project.
//

import Foundation

extension String {
    
    // check if the string contains otherString, return accordingly.
    func contains(otherString:String!) -> Bool {
        if self.rangeOfString(otherString) != nil{
            return true
        } else {
            return false
        }
    }
    
}