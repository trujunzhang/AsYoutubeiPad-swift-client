//
//  YTVideoWatchInfoViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideoWatchInfoViewController: UIViewController {
    
    var videoID = ""
    private var isBarsOpen  = true
    var lastHeight :CGFloat = 0
    
    let COLLAPSE_HEIGHT :CGFloat = 60
    
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let rect:CGRect =  self.view.frame
        lastHeight = rect.size.height
        
        println(" watch info view' height is \(lastHeight) ")
    }
    
    
    @IBAction func onClickExpand(sender: AnyObject) {
        toggleBars()
    }
    
    func toggleBars(){
        
        if(isBarsOpen  == true){
            hideAllBars()
        }else{
            showAllBars()
        }
    }
    
    func showTopBar(){
//        popAnimationForTopBar(_topBarTopConstraint, destY: 0, key: "showTopBar")
    }
    
    func hideTopBar(){
//        popAnimationForTopBar(_topBarTopConstraint, destY: -WATCH_BAR_HEIGHT, key: "hideTopBar")
    }
    
    func hideAllBars(){
        hideTopBar()
        hideBottomBar()
        
        isBarsOpen = false
    }
    
    func showBottomBar(){
//        popAnimationForTopBar(_bottomBarTopConstraint, destY: 0, key: "showBottomBar")
    }
    
    func hideBottomBar(){
//        popAnimationForTopBar(_bottomBarTopConstraint, destY: -WATCH_BAR_HEIGHT, key: "hideBottomBar")
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
                let constraint:NSLayoutConstraint = object as! NSLayoutConstraint
                constraint.constant = values[0]
            }
            
            // this helps Pop determine when the animation is over
            prop.threshold = 0.01
            
            
        }) as! POPAnimatableProperty
        
        spring.property = property
        spring.toValue = destY
        
        object.pop_addAnimation(spring, forKey: "spring")
    }

    
    
    
}