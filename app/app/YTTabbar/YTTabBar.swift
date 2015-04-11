//
//  YTTabBar.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

protocol YTTabBarDelegate  {
    func tabBar(tabBar: YTTabBar, didPressButton button: UIButton, atIndex tabIndex:NSInteger)
}

class YTTabBar:UIView {
    var delegate:YTTabBarDelegate?
    
    var selectedButton:UIButton?
    var selectedViewController:UIViewController?
    
    // Mark : Private variables
    var tabBarItemsDictionary:TabBarItemsDictionary?
    
    
    
    init(frame: CGRect,  _tabBarItemsDictionary:TabBarItemsDictionary) {
        super.init(frame: frame)
        
        tabBarItemsDictionary = _tabBarItemsDictionary
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has! not been implemented")
    }
    
    
    func initSubViewsWithControllers(){
        
        
    }
    
    // Mark :
//    func setSelectedButton(_selectedButton:UIButton){
//        //        var oldButtonIndex = buttons?.indexOfObject(selectedButton!)
//        //        var newButtonIndex = buttons?.indexOfObject(_selectedButton)
//        //
//        //        if (oldButtonIndex != NSNotFound) {
//        //            selectedButton?.setImage(nil, forState: .Normal)
//        //        }
//        //
//        //        if (newButtonIndex != NSNotFound) {
//        //            selectedButton?.setImage(nil, forState: .Normal)
//        //        }
//        
//        selectedButton = _selectedButton
//    }
    
    
    
    
    
}