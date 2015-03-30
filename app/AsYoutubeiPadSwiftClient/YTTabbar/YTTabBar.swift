//
//  YTTabBar.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

protocol YTTabBarDelegate  {
    func tabBar(tabBar: YTTabBar, didPressButton button: UIButton, atIndex tabIndex:NSInteger)
}

class YTTabBar:UIView {
    var delegate:YTTabBarDelegate?
    var selectedButton:UIButton?
    var selectedViewController:UIViewController?
    

     init(frame: CGRect, viewControllers: NSMutableArray, appearance:NSDictionary) {
        super.init(frame: frame)
    }

     required init(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    
    
}