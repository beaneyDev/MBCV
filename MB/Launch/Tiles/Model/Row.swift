//
//  Row.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation

class Row {
    var tiles: [TileVM]?
    var proportion: Float?
    
    init(tiles: [TileVM], proportion: Float) {
        self.tiles = tiles
        self.proportion = proportion
    }
}
