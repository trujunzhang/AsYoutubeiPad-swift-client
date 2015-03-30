//
//  YTTabBarController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol YTTabBarControllerDelegate  {
    func ytTabBarController(tabBarController: YTTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    func ytTabBarController(tabBarController: YTTabBarController, didSelectViewController viewController: UIViewController) -> Bool
}


class YTTabBarController: UIViewController {
    
    var viewControllers:NSArray?
    var selectedViewController:UIViewController?
    var selectedIndex:NSInteger = 0
    var delegate:YTTabBarControllerDelegate?
    var tabBarAppearanceSettings:NSDictionary?
    var debug:Bool?

//    override init() {
//        
//    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
    }
}