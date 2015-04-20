//
//  CartoWatchViewController.swift
//  app
//
//  Created by djzhang on 4/14/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class CartoWatchViewController : UIViewController {
    // MARK : All containers
    var _moviePlayContainer: UIView?
    var _videoInfoContainer: UIView?
    var _videoOtherContainer: UIView?
    
    var group:Cartography.ConstraintGroup =  Cartography.ConstraintGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize all containers
        makeAllContainers()
    }
    
    func makeAllContainers(){
        _moviePlayContainer = UIView()
        _moviePlayContainer?.backgroundColor = UIColor.redColor()
        self.view.addSubview(_moviePlayContainer!)
        
        _videoInfoContainer = UIView()
        _videoInfoContainer?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(_videoInfoContainer!)
        
        _videoOtherContainer = UIView()
        _videoOtherContainer?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(_videoOtherContainer!)
    }
    
    override func viewDidLayoutSubviews() {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue { //landscape
            setupViewHorizontalLayout()
        } else {// portraight
            setupViewVerticalLayout()
        }
        
        //        setupViewHorizontalLayout()
    }
    
    func setupViewVerticalLayout(){
        
        group = constrain(_moviePlayContainer!,_videoInfoContainer!,_videoOtherContainer!, replace: group) { view1,view2,view3 in
            // _moviePlayContainer
            view1.leading   == view1.superview!.leading
            view1.trailing  == view1.superview!.trailing
            view1.top       == view1.superview!.top
            
            view1.height  == (view1.width * 324) / 576
            
            // _videoInfoContainer
            view2.leading   == view2.superview!.leading
            view2.trailing  == view2.superview!.trailing
            
            view2.top      == view1.bottom
            view2.height   == 0
            
            // _videoOtherContainer
            view3.leading   == view3.superview!.leading
            view3.trailing  == view3.superview!.trailing
            
            view3.top      == view1.bottom
            view3.bottom   == view3.superview!.bottom
            
        }
    }
    
    func setupViewHorizontalLayout(){
        
        group = constrain(_moviePlayContainer!,_videoInfoContainer!,_videoOtherContainer!, replace: group) { view1,view2,view3 in
            // _moviePlayContainer
            view1.leading == view1.superview!.leading
            view1.top     == view1.superview!.top
            
            view1.width   == (view1.superview!.width/3)*2
            view1.height  == (view1.width * 324) / 576
            
            // _videoInfoContainer
            view2.leading  == view2.superview!.leading
            view2.bottom   == view2.superview!.bottom
            
            view2.top      == view1.bottom
            view2.width    == view1.width
            
            // _videoOtherContainer
            view3.top       == view3.superview!.top
            view3.trailing  == view2.superview!.trailing
            view3.bottom    == view3.superview!.bottom
            
            view3.leading == view1.trailing
            
        }
    }
    
    
    
}