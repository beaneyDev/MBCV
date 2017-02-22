//
//  RowVM.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class RowVM: NSObject {
    var row: Row?
    
    init(row: Row) {
        self.row = row
    }
    
    var tiles: [TileVM] {
        return self.row?.tiles ?? []
    }
}
