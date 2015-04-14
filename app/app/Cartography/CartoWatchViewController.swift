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
    
    @IBOutlet weak var moviePlayContainer: UIView!
    
    @IBOutlet weak var videoInfoContainer: UIView!
    
    @IBOutlet weak var videoOtherContainer: UIView!
    
    var group:Cartography.ConstraintGroup =  Cartography.ConstraintGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect:CGRect = moviePlayContainer.frame
        println("rect : \(rect)")
        
        LayoutUtils.LayoutFullView(self.moviePlayContainer!)
        
//         setupViewHorizontalLayout()
    }
    
    
    override func viewDidLayoutSubviews() {
//        if UIDevice.currentDevice().orientation.isLandscape.boolValue { //landscape
//            setupViewHorizontalLayout()
//        } else {// portraight
//            setupViewVerticalLayout()
//        }
    }
    
    func setupViewVerticalLayout(){
        
    }
    
    func setupViewHorizontalLayout(){
        
       layout(moviePlayContainer!) { view1 in
            
//            view1.leading == view1.superview!.leading
//            view1.top == view1.superview!.top
            
            
            view1.width   == 576
            view1.height  == 10
        }
    }
    
    
    @IBAction func onClickBarButton(sender: AnyObject) {
        var x = 0
    }
    
    
}