//
//  YTTabbarConstants.swift
//  app
//
//  Created by djzhang on 4/27/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let TAB_BAR_HEIGHT:CGFloat = 42

extension YTTabBarItemsViewController {
    
    class func instance() -> YTTabBarItemsViewController {
        
        var viewController: YTTabBarItemsViewController = UIStoryboard(name: "ReusedViewControllers", bundle: nil).instantiateViewControllerWithIdentifier("YTTabBarItemsViewController") as! YTTabBarItemsViewController
        
        return viewController
    }
}