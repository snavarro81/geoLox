//
//  WildcardGestureRecognizer.swift
//
//
//  Created by snavarro on 11/27/15.
//  Copyright © 2015 snavarro. All rights reserved.
//

import UIKit
import Foundation

typealias WildcardGestureRecognizerHandler = ( touches: NSSet, event: UIEvent) -> ()

class WildcardGestureRecognizer: UIGestureRecognizer {
    
    var handlerTouchesBegan:WildcardGestureRecognizerHandler?
    var handlerTouchesEnded:WildcardGestureRecognizerHandler?
    
    override init(target: AnyObject!, action: Selector) {
        super.init(target: target, action: action)
        self.cancelsTouchesInView = false
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
       self.handlerTouchesBegan?(touches: touches, event: event)
    }
    
    func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        //TODO
    }
    
    func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        self.handlerTouchesEnded?(touches: touches, event: event)
    }
    
    func touchesMoved(touches: NSSet!, withEvent event: UIEvent!)  {
        //TODO
    }
    
    func reset() {
        //TODO
    }
    
    func ignoreTouch(touch: UITouch!, forEvent event: UIEvent!)  {
        //TODO
    }
    
    func canBePreventedByGestureRecognizer(preventingGestureRecognizer:UIGestureRecognizer!) -> Bool {
        return false
    }
    
    func canPreventGestureRecognizer(preventedGestureRecognizer: UIGestureRecognizer!) -> Bool  {
        return false
    }
}
