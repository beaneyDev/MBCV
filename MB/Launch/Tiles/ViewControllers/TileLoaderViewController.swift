//
//  TileLoaderViewController.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBUtils

class TileLoaderViewController: LoaderViewController {
    var rows = [RowVM]()
    var rowViews = [RowView]()
    var gridProportion: (Float, Float) = (3.0, 5.0)
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        self.populateRows()
        self.layoutRows()
        self.animateRows()
    }
    
    func populateRows() {
        //Create a grid of the screen
        let numberOfRows = Int(gridProportion.1)
        let numberOfColumns = Int(gridProportion.0)
        
        for _ in 1...numberOfRows {
            var tiles = [TileVM]()
            for _ in 1...numberOfColumns{
                let padding: Padding = Padding(top: 2, left: 2, bottom: 2, right: 2)
                let tile = Tile(color: "#eeeeee", highlightedColor: "#94c1d0", animateType: .fade, proportion: gridProportion.0, padding: padding)
                let tileVM = TileVM(tile: tile)
                tiles.append(tileVM)
            }
            
            let row = Row(tiles: tiles, proportion: gridProportion.1)
            self.rows.append(RowVM(row: row))
        }
    }
    
    func layoutRows() {
        var previousRow: RowView?
        for row in rows {
            let rowView = RowView()
            self.rowViews.append(rowView)
            rowView.row = row
            rowView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(rowView)
            
            var top = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
            
            if let previousRow = previousRow {
                top = NSLayoutConstraint(item: rowView, attribute: .top, relatedBy: .equal, toItem: previousRow, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            }
            
            let heightMultiplier = CGFloat(1.0 / gridProportion.1)
            
            let height = NSLayoutConstraint(item: rowView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: heightMultiplier, constant: 0.0)
            
            //Horizontal
            let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[row]|", options: [], metrics: nil, views: ["row": rowView])
            
            //Add constraints
            self.view.addConstraints(horizontal)
            self.view.addConstraints([top, height])
            
            previousRow = rowView
        }
        
        self.view.bringSubview(toFront: logo)
    }
    
    var animationIndex = 0
    func animateRows() {
        if animationIndex < self.rows.count {
            self.rowViews[animationIndex].animate {
                self.animationIndex += 1
                self.animateRows()
            }
        } else {
            self.animationIndex = 0
            
            UIView.animate(withDuration: 0.4, animations: { 
                for row in self.rowViews {
                    row.center = self.view.center
                }
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.4, animations: { 
                    for row in self.rowViews {
                        row.alpha = 0.0
                    }
                }, completion: { (finished) in
                    UIView.animate(withDuration: 0.4, animations: { 
                        self.logo.alpha = 0.0
                    }, completion: { (finished) in
                        self.moveOn()
                    })
                })
            })            
        }
    }
}
