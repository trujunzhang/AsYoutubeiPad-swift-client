//
//  CartoVideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class CartoVideoInfoViewController: UIViewController {
    
    @IBOutlet weak var videoInfoContainer: UIView!
    
    var videoInfoViewController:YTVideoWatchInfoViewController?
    var videoInfoRootView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoInfoViewController = StoryBoardUtils.getYTVideoWatchInfoViewController()
        
        if let controller : UIViewController = videoInfoViewController{
            self.addChildViewController(controller)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let controller : UIViewController = videoInfoViewController{

            videoInfoRootView = controller.view
            
            self.videoInfoContainer.addSubview(videoInfoRootView!)
            
            LayoutUtils.LayoutFullView(videoInfoRootView!)
        }
    }
    
    
    
}
