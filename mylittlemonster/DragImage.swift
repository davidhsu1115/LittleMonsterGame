//
//  DragImage.swift
//  mylittlemonster
//
//  Created by fangwiehsu on 2016/6/7.
//  Copyright © 2016年 fangwiehsu. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView{
    
    //create a variable to hold our position
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    
    //if we create a sub class we need to init the UIImageView by override it
    //and we still need to call the super class of UIImageView class
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        originalPosition = self.center //self.center means the center of the imageview you touch
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first{  //if the imageView is moving
            
            let position = touch.locationInView(self.superview) //self.superView = the position in the ViewController
            self.center = CGPointMake(position.x, position.y) 
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget{
            
            let position = touch.locationInView(self.superview)
            
            //if you drop the heart or the food on the target frame
            if CGRectContainsPoint(target.frame, position){
                
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                //equal to --> NSNotificationCenter.defaultCenter().postNotification(NSNotification(nofit)
                //var nofit = NSNotification(name: "onTargerDropped", object: nil)
            }
        }
        
        
        self.center = originalPosition  //if the user let go the imageView it will come back to it's original position.
        
    }
}