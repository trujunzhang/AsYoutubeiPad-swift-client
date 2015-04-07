//
//  MovieEmbeddedBasedBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/7/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let WATCH_BAR_HEIGHT:CGFloat = 43

class MovieEmbeddedBasedBarViewController :UIViewController {
    
    var tapGesture : UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestures()
    }
    
    // MARK : Tap Gesture to show or hide bars
    
    func addGestures(){
        tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(tapGesture!)
    }
    
    func tapGesture(sender: UITapGestureRecognizer){
       var x = 0
    }
    
    // MARK : pop animate
    
    func popAnimationForTopBar(object : AnyObject){
        let rWidth:CGFloat = -WATCH_BAR_HEIGHT
        
        let spring : POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        
        
        let property: POPAnimatableProperty = POPAnimatableProperty.propertyWithName("com.rwt.heightContstraint", initializer: { (object) -> Void in
            
            let prop:POPMutableAnimatableProperty = object as POPMutableAnimatableProperty
            
            // note the object used is NSLayoutConstraint, the same object we assign the animation to
            prop.readBlock = {(constraint,values) -> Void in
                values[0] = constraint.constant
            }
            
            prop.writeBlock = {(object,values) -> Void in
                let constraint:NSLayoutConstraint = object as NSLayoutConstraint
                constraint.constant = values[0]
            }
            
            // this helps Pop determine when the animation is over
            prop.threshold = 0.01
            
            
        }) as POPAnimatableProperty
        
        spring.property = property
        spring.toValue = rWidth
        
        object.pop_addAnimation(spring, forKey: "spring")
    }

    
}