//
//  Padding.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation

class Padding {
    var top: Float = 0.0
    var bottom: Float = 0.0
    var right: Float = 0.0
    var left: Float = 0.0
    
    init(top: Float, left: Float, bottom: Float, right: Float) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}
