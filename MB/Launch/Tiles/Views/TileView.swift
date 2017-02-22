//
//  TileView.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit
import MBUtils

class TileView: UIView {
    var innerView: UIView!
    var shouldAnimate: Bool = false
    var tile: TileVM? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.innerView = UIView()
        layout()
        color()
    }
    
    func configure() {
        layout()
        color()
    }
    
    func layout() {
        self.innerView.alpha = 0.4
        guard let tile = self.tile else {
            return
        }
        
        self.innerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.innerView)
        let views = ["innerView": self.innerView as Any]
        
        let padding = tile.padding
        
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding.top)-[innerView]-\(padding.bottom)-|", options: [], metrics: nil, views: views)
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding.left)-[innerView]-\(padding.right)-|", options: [], metrics: nil, views: views)
        self.addConstraints(vConstraint)
        self.addConstraints(hConstraint)
    }
    
    func color() {
        self.innerView.backgroundColor = self.tile?.color
    }
    
    func animate(completion: @escaping () -> ()) {
        for constraint in self.constraints {
            constraint.constant = constraint.constant + 2
        }
        
        
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
            self.innerView.backgroundColor = self.tile?.highlightedColor
        }, completion: { (finished) in
            MBOn.main {
                for constraint in self.constraints {
                    constraint.constant = constraint.constant - 2
                }
                
                UIView.animate(withDuration: 0.4, animations: {
                    self.layoutIfNeeded()
                    self.innerView.backgroundColor = self.tile?.color
                })
            }
        });
        
        MBOn.delay(0.04, task: {
            completion()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
