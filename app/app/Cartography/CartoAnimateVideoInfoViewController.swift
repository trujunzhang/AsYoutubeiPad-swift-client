//
//  CartoAnimateVideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class CartoAnimateVideoInfoViewController: UIViewController {
    var videoInfoViewController:YTVideoWatchInfoViewController?
    
    override func viewDidLoad() {
        
        videoInfoViewController = WatchViewStoryboardUtils.getYTVideoWatchInfoViewController()
        
        if let controller : UIViewController = videoInfoViewController{
            self.addChildViewController(controller)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if let controller : UIViewController = videoInfoViewController{
            self.view.addSubview(controller.view!)
            LayoutUtils.LayoutFullView(controller.view!)
        }
        
    }
    
}