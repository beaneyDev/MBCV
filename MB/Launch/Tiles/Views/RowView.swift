//
//  RowView.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBUtils

class RowView: UIView {
    var row: RowVM? {
        didSet {
            layout()
        }
    }
    
    var tileViews = [TileView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func layout() {
        guard let row = row else {
            return
        }
        
        var previousTile: TileView?
        for tile in row.tiles {
            let tileView = TileView()
            self.tileViews.append(tileView)
            tileView.tile = tile
            tileView.translatesAutoresizingMaskIntoConstraints = false
            self.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(tileView)
            
            var left = NSLayoutConstraint(item: tileView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
            
            if let previousTile = previousTile {
                left = NSLayoutConstraint(item: tileView, attribute: .leading, relatedBy: .equal, toItem: previousTile, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            }
            
            let widthMultiplier = CGFloat(1.0 / tile.proportion)
            
            let width = NSLayoutConstraint(item: tileView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: widthMultiplier, constant: 0.0)
            
            //Horizontal
            let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "V:|[tile]|", options: [], metrics: nil, views: ["tile": tileView])
            
            //Add constraints
            self.addConstraints(horizontal)
            self.addConstraints([left, width])
            
            previousTile = tileView
        }
    }
    
    var animationIndex = 0
    func animate(completion: @escaping () -> ()) {
        if animationIndex < self.row?.tiles.count ?? 0 {
            self.tileViews[animationIndex].animate {
                self.animationIndex += 1
                self.animate(completion: completion)
            }
        } else {
            animationIndex = 0
            completion()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
