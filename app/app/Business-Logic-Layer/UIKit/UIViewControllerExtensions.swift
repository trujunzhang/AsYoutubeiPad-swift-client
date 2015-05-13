//
//  UIViewControllerExtensions.swift
//  app
//
//  Created by djzhang on 5/13/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

extension UIViewController {
    
    // MARK:
    func addLoadingViewPanel(viewController:LoadingViewController){
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.layoutPanel()
    }
    
    func removeLoadingViewPanel(viewController:LoadingViewController){
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
    }
    
    // MARK
    func insertRequestFailureViewPanel(viewController:RequestFailureViewController){
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.layoutPanel()
    }
    
    // MARK: Loading panel
    /**
    example: 
           showLoadingPanel(loadingViewController)
    
    :param: loadingViewController
    */
    func showLoadingPanel(viewController:LoadingViewController) {
        addLoadingViewPanel(viewController)
        viewController.showLoadingPanel()
    }
    
    func hideLoadingPanel(viewController:LoadingViewController) {
        viewController.hideLoadingPanel()
        removeLoadingViewPanel(viewController)
    }
    
    //    var refreshControl: UIRefreshControl  = UIRefreshControl()
    
    //    func configureRefreshControl(action: Selector) {
    //        refreshControl = UIRefreshControl()
    //        refreshControl?.addTarget(self, action: action, forControlEvents: .ValueChanged)
    //    }
    
}