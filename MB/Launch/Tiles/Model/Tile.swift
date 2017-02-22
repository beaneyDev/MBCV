//
//  Tile.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation

enum AnimationType: String {
    case flip
    case fade
}

class Tile: NSObject {
    var color: String?
    var highlightedColor: String?
    var animateType: AnimationType?
    var proportion: Float?
    var padding: Padding?
    
    init(color: String, highlightedColor: String, animateType: AnimationType, proportion: Float, padding: Padding) {
        super.init()
        self.color = color
        self.animateType = animateType
        self.proportion = proportion
        self.padding = padding
        self.highlightedColor = highlightedColor
    }
}

