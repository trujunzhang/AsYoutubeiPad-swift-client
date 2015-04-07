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
    
    private var _topBarTopConstraint: NSLayoutConstraint!
    private var _bottomBarTopConstraint: NSLayoutConstraint!
    
    private var isBarsOpen  = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestures()
    }
    
    func setBarsConstraint(topBarTopConstraint: NSLayoutConstraint,bottomBarTopConstraint: NSLayoutConstraint){
        _topBarTopConstraint = topBarTopConstraint
        _bottomBarTopConstraint = bottomBarTopConstraint
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        assert(_topBarTopConstraint != nil, "_topBarTopConstraint not setup")
        assert(_bottomBarTopConstraint != nil, "_bottomBarTopConstraint not setup")
        
        delayHideTwoBars()
    }
    
    // MARK : hide Top and Bottom bars after xxx seconds
    func delayHideTwoBars(){
        self.performClosureAfterDelay(4, block: { () -> Void in
            self.hideAllBars()
        })
    }
    
    // MARK : Tap Gesture to show or hide bars
    
    func addGestures(){
        tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        self.view.addGestureRecognizer(tapGesture!)
    }
    
    func tapGesture(sender: UITapGestureRecognizer){
        toggleBars()
        delayHideTwoBars()
    }
    
    // MARK : pop animate
    func toggleBars(){
        
        if(isBarsOpen  == true){
            hideAllBars()
        }else{
            showAllBars()
        }
    }
    
    func showTopBar(){
        popAnimationForTopBar(_topBarTopConstraint, destY: 0, key: "showTopBar")
    }
    func hideTopBar(){
        popAnimationForTopBar(_topBarTopConstraint, destY: -WATCH_BAR_HEIGHT, key: "hideTopBar")
    }
    
    func hideAllBars(){
        hideTopBar()
        hideBottomBar()
        
        isBarsOpen = false
    }
    
    func showBottomBar(){
        popAnimationForTopBar(_bottomBarTopConstraint, destY: 0, key: "showBottomBar")
    }
    
    func hideBottomBar(){
        popAnimationForTopBar(_bottomBarTopConstraint, destY: -WATCH_BAR_HEIGHT, key: "hideBottomBar")
    }
    
    func showAllBars(){
        showTopBar()
        showBottomBar()
        
        isBarsOpen = true
    }
    
    func popAnimationForTopBar(object : AnyObject,destY:CGFloat,key: NSString){
        pop_removeAnimationForKey("")
        
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
        spring.toValue = destY
        
        object.pop_addAnimation(spring, forKey: "spring")
    }
    
    
}