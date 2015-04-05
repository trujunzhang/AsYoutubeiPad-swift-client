//
//  YTTabBarController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography


protocol YTTabBarControllerDelegate  {
    func ytTabBarController(tabBarController: YTTabBarController, shouldSelectViewController viewController: UIViewController) -> Bool
    func ytTabBarController(tabBarController: YTTabBarController, didSelectViewController viewController: UIViewController) -> Bool
}


class YTTabBarController: UIViewController {
    
    var viewControllers = NSDictionary()
    
    var selectedViewController:UIViewController?
    var selectedIndex = 0
    
    var delegate:YTTabBarControllerDelegate?
    
    var tabBarAppearanceSettings = NSDictionary()
    
    var debug = false
    
    // Mark : Private variables
    var presentationView:UIView?
    var isFirstAppear = false
    
    var tabBarItemsView : UIView?
    var tabBarItemsViewController : YTTabBarItemsViewController?
    var tabBarItemsDictionary:TabBarItemsDictionary?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1
        var _tabBarItemsViewController: YTTabBarItemsViewController = StoryBoardUtils.getYTTabBarItemsViewController()
        
        let _tabBarItemsView:UIView = _tabBarItemsViewController.view!
        
        tabBarItemsViewController = _tabBarItemsViewController
        tabBarItemsView = _tabBarItemsView
        self.addChildViewController(tabBarItemsViewController!)
        
        tabBarItemsDictionary =  tabBarItemsViewController?.makeTabBarItemsDictionary()
        
        // 2
        presentationView = UIView()
        
        presentationView?.backgroundColor = UIColor.blueColor()
        
        // 3
        self.view.addSubview(_tabBarItemsView)
        self.view.addSubview(presentationView!)
        
        // 4
        layout(tabBarItemsView!,presentationView!) { view1,view2 in
            
            view1.centerX == view1.superview!.centerX
            view2.centerX == view1.centerX
            
            view1.width   == view1.superview!.width
            view2.width   == view1.width
            
            view1.height  == TAB_HEIGHT
            
            view1.top     == view1.superview!.top
            view2.top     == view1.bottom
            
            view2.bottom  == view2.superview!.bottom
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        // 5
        self.viewFirstViewController()
    }
    
    func viewFirstViewController() {
        // Select first view controller on first Launch.
        if(isFirstAppear == false){
            isFirstAppear = true
            
            var dictionary = tabBarItemsDictionary?.viewControllers
            
            var dic:NSMutableDictionary = dictionary!
            
            let controller : UIViewController = dic.objectForKey("Activity") as UIViewController
            
            var bDictionary = tabBarItemsDictionary?.buttons
            
            let button : UIButton = bDictionary?.objectForKey("Activity") as UIButton
            
            self.selectViewController(controller, withButton: button)
        }
    }
    
    // Mark : View Controller Selection
    func selectViewController(viewController:UIViewController, withButton button:UIButton) {
        //        tabBarView?.setSelectedButton(button)
        selectViewController(viewController)
    }
    
    func selectViewController(viewController:UIViewController){
        let subviews = presentationView?.subviews
        if(subviews?.count > 0){
            let presentedView:UIView = subviews?.first! as UIView
            presentedView.removeFromSuperview()
        }
        
        presentationView?.addSubview(viewController.view)
        fitView(viewController.view, intoView: presentationView!)
    }
    
    func fitView(toPresentView:UIView, intoView containerView:UIView ){
        layout(toPresentView,containerView) { view1,view2 in
            
            view1.centerX == view2.centerX
            view1.centerY == view2.centerY
            
            view1.width   == view2.width
            view1.height  == view2.height
        }
    }
    
    
    // Mark : YTTabBarDelegate
    //    func tabBar(tabBar: YTTabBar, didPressButton button: UIButton, atIndex tabIndex:NSInteger){
    //
    //    }
    
    
}