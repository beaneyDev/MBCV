//
//  LoaderViewController.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class LoaderViewController: UIViewController {
    override func viewDidLoad() {
        
    }
    
    func moveOn() {
        self.performSegue(withIdentifier: "firstLaunch", sender: nil)
    }
}
