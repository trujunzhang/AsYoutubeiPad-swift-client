//
//  YTTabBarItemsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

struct TabBarItemsDictionary {
    var buttons:NSMutableDictionary?
    var viewControllers:NSMutableDictionary?
}



class YTTabBarItemsViewController:UIViewController {
    
    @IBOutlet var buttonGroupPanel: UIView!
    
    
    @IBOutlet var activityButton: UIButton!
    
    @IBOutlet var videosButton: UIButton!
    
    @IBOutlet var playListButton: UIButton!
    
    @IBOutlet var separator1: UIImageView!
    
    @IBOutlet var separator2: UIImageView!
    
    let tabBarItemsDictionary:TabBarItemsDictionary?
    
    override func viewDidLoad() {
        
//        layout(buttonGroupPanel!) { view1 in
//            
//            view1.centerX == view1.superview!.centerX
//            view1.width == 322
//            
//            view1.top == view1.superview!.top
//        }

    }
    
    func makeTabBarItemsDictionary() ->TabBarItemsDictionary {
        let controller:UIViewController? = UIViewController()
        
        //1
        let buttons:NSMutableDictionary = NSMutableDictionary()
        buttons.setObject(activityButton!, forKey: "Activity")
        buttons.setObject(videosButton!, forKey: "Videos")
        buttons.setObject(playListButton!, forKey: "PlayList")
        
        //2
        let viewControllers:NSMutableDictionary = NSMutableDictionary()
        viewControllers.setObject(controller!, forKey: "Activity")
        viewControllers.setObject(controller!, forKey: "Videos")
        viewControllers.setObject(controller!, forKey: "PlayList")
        
        
        return TabBarItemsDictionary(buttons: buttons, viewControllers: viewControllers)
    }
    
    
    
}