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
        
      group =   constrain(_moviePlayContainer!,_videoInfoContainer!,_videoOtherContainer!, replace: group) { view1,view2,view3 in
            view1.leading == view1.superview!.leading
            view1.top == view1.superview!.top
            
            
            view1.width   == 100
            view1.height  == 324
        }
    }
    
    func setupViewHorizontalLayout(){
        
      group =   constrain(_moviePlayContainer!,_videoInfoContainer!,_videoOtherContainer!, replace: group) { view1,view2,view3 in
            view1.leading == view1.superview!.leading
            view1.top == view1.superview!.top
            
            
            view1.width   == 576
            view1.height  == 324
        }
    }
    

    
}