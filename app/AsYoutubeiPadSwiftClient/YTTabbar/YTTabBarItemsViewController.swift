//
//  YTTabBarItemsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/31/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

struct TabBarItemsDictionary {
    var buttons:NSMutableDictionary?
    var viewControllers:NSMutableDictionary?
}

class YTTabBarItemsViewController:UIViewController {
    
    @IBOutlet var activityButton: UIButton!
    
    @IBOutlet var videosButton: UIButton!
    
    @IBOutlet var playListButton: UIButton!
    
    let tabBarItemsDictionary:TabBarItemsDictionary?
    
    override func viewDidLoad() {
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