//
//  WildcardGestureRecognizer.swift
//  RouteCompare
//
//  Created by Taras Kalapun on 25/07/14.
//  Copyright (c) 2014 Kalapun. All rights reserved.
//

import UIKit
import Foundation

typealias WildcardGestureRecognizerHandler = ( touches: NSSet, event: UIEvent) -> ()

class WildcardGestureRecognizer: UIGestureRecognizer {
    
    var handler:WildcardGestureRecognizerHandler?
    
    override init(target: AnyObject!, action: Selector) {
        super.init(target: target, action: action)
        self.cancelsTouchesInView = false
    }
    
    
    init(handler: WildcardGestureRecognizerHandler) {
        super.init(target: nil, action: nil)
        self.handler = handler
        self.cancelsTouchesInView = false
    }
    
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // do your stuff
        //self.state = .Began
        self.handler?(touches: touches, event: event)
        
        
    }
    
    func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        
    }
    
    func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        
    }
    
    func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)  {
        
    }
    
    func reset() {
        
    }
    
    func ignoreTouch(touch: UITouch!, forEvent event: UIEvent!)  {
        
    }
    
    func canBePreventedByGestureRecognizer(preventingGestureRecognizer: UIGestureRecognizer!) -> Bool {
        return false
    }
    
    func canPreventGestureRecognizer(preventedGestureRecognizer: UIGestureRecognizer!) -> Bool  {
        return false
    }
}
