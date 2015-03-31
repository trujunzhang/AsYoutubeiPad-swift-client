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


class YTTabBarController: UIViewController,YTTabBarDelegate {
    
    var viewControllers:NSDictionary?
    var selectedViewController:UIViewController?
    var selectedIndex:NSInteger = 0
    var delegate:YTTabBarControllerDelegate?
    var tabBarAppearanceSettings:NSDictionary?
    var debug:Bool?
    
    // Mark : Private variables
    var presentationView:UIView?
    var tabBarView:YTTabBar?
    var isFirstAppear:Bool?
    
    
    init(_viewControllers: NSDictionary, tabBarView _tabBarView: UIView){
        super.init()
        
        viewControllers = _viewControllers
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        //        tabBarView = YTTabBar(frame: CGRectZero, viewControllers: nil, appearance: nil)
        //        tabBarView.delegate = self
        
        presentationView = UIView()
        
        self.view.addSubview(tabBarView!)
        self.view.addSubview(presentationView!)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //         NSParameterAssert(_viewControllers.count > 0);
        
        // Select first view controller on first Launch.
        if(isFirstAppear == false){
            isFirstAppear = true
            //            [self selectViewController:[_viewControllers firstObject]];
            
        }
    }
    
    // Mark : View Controller Selection
    func selectViewController(viewController:UIViewController, withButton button:UIButton) {
        tabBarView?.setSelectedButton(button)
        selectViewController(viewController)
    }
    
    func selectViewController(viewController:UIViewController){
        if let presentedView:UIView = presentationView?.subviews.first! as? UIView {
            presentedView.removeFromSuperview()
        }
        
        presentationView?.addSubview(viewController.view)
        fitView(viewController.view, intoView: presentationView!)
    }
    
    func fitView(toPresentView:UIView, intoView containerView:UIView ){
        
    }
    
    
    // Mark : YTTabBarDelegate
    func tabBar(tabBar: YTTabBar, didPressButton button: UIButton, atIndex tabIndex:NSInteger){
        
    }
    
    
}