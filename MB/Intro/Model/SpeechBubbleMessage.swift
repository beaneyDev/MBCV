//
//  SpeechBubbleMessage.swift
//  MB
//
//  Created by Matt Beaney on 15/01/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation

enum BubblePosition: String {
    case left
    case right
}

class SpeechBubbleMessage: NSObject {
    var message: String?
    var position: BubblePosition?
    
    init(message: String, position: BubblePosition) {
        self.message = message
        self.position = position
    }
}
