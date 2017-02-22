//
//  TileVM.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBUtils

class TileVM: NSObject {
    var tile: Tile?
    var stringy = ""
    
    init(tile: Tile) {
        self.tile = tile
        super.init()
    }
    
    var color: UIColor? {
        return MBColorConverter.hexStringToOptionColour(self.tile?.color)
    }
    
    var highlightedColor: UIColor? {
        return MBColorConverter.hexStringToOptionColour(self.tile?.highlightedColor)
    }
    
    var proportion: Float {
        return self.tile?.proportion ?? 2.0
    }
    
    var padding: Padding {
        return self.tile?.padding ?? Padding(top: 0, left: 0, bottom: 0, right: 0)
    }
}
