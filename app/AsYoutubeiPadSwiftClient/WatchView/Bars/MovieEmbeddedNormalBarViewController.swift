//
//  MovieEmbeddedNormalBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography



class MovieEmbeddedNormalBarViewController: MovieEmbeddedBasedBarViewController {
    
    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!
    
    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!
    //    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 43)
    
    // MARK : Bottom bar items
    
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var cancelButton: UIImageView!
    @IBOutlet var fullscreenButton: UIImageView!
    
    // MARK : Top bar items
    
    @IBOutlet var topBarTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var repeatButton: UIButton!
    @IBOutlet var ccButton: UIButton!
    @IBOutlet var watchLaterButton: UIButton!
    
    // MARK : Test views
    
    @IBOutlet var animatedView: UIView!

    @IBOutlet var containerHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view : UIView = bottomBarPanel
        
        hideTwoBars()
    }
    
    // MARK : Events for Top buttons
    @IBAction func repeatButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    @IBAction func ccButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    @IBAction func watchLaterButtonEvent(sender: AnyObject) {
        var x = 0
    }
    
    // MARK : hide Top and Bottom bars after xxx seconds
    func hideTwoBars(){
        self.performClosureAfterDelay(4, block: { () -> Void in
            
            self.popAnimationForTopBar()
            
        })
    }
    
    func popAnimationForTopBar(){
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
        
        self.topBarTopConstraint.pop_addAnimation(spring, forKey: "spring")
    }
    
    
    override func viewDidLayoutSubviews() {
        
    }
    
}




