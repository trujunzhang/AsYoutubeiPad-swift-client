//
//  UIViewControllerExtensions.swift
//  app
//
//  Created by djzhang on 5/13/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

extension UIViewController {
    
    // MARK: -
    func addLoadingViewPanel(viewController:LoadingViewController,parentViewController:UIViewController,superView:UIView){
        parentViewController.addChildViewController(viewController)
//        println("superView is \(superView)")
//        println("viewController.view is \(viewController.view)")
        superView.addSubview(viewController.view)
        viewController.layoutPanel()
    }
    
    func removeLoadingViewPanel(viewController:LoadingViewController){
        viewController.removeFromParentViewController()
        viewController.view.removeFromSuperview()
    }
    
    // MARK: -
    func insertRequestFailureViewPanel(viewController:RequestFailureViewController){
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        viewController.layoutPanel()
    }
    
    // MARK: Loading event
    /**
    example: 
           showLoadingPanel(loadingViewController)
    
    :param: loadingViewController
    */
    func showAndAddLoadingPanel(viewController:LoadingViewController,parentViewController:UIViewController,superView:UIView) {
        addLoadingViewPanel(viewController,parentViewController:parentViewController,superView:superView)
        viewController.showLoadingPanel()
    }
    
    func hideAndRemoveLoadingPanel(viewController:LoadingViewController) {
        viewController.hideLoadingPanel()
        removeLoadingViewPanel(viewController)
    }

    
}