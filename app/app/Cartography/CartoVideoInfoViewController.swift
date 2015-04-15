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
    
    var myscr : UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createview()
        
        videoInfoViewController = StoryBoardUtils.getYTVideoWatchInfoViewController()
        
        if let controller : UIViewController = videoInfoViewController{
            self.addChildViewController(controller)
            
            videoInfoRootView = controller.view
        }
        
    }
    
    func createview(){
        myscr = UIScrollView()
        //        myscr!.frame = CGRectMake(0,0,300,300)
        //        myscr!.contentSize = CGSizeMake(300,300)
        myscr!.scrollEnabled = true
        myscr!.backgroundColor = UIColor.whiteColor()
        
        if let subView : UIScrollView = myscr{
            videoInfoContainer.addSubview(subView)
            LayoutUtils.LayoutFullView(subView)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let controller : UIViewController = videoInfoViewController{
            
            //            videoInfoRootView = controller.view
            
            if let subView : UIScrollView = myscr{
                subView.addSubview(videoInfoRootView!)
            }
            
            LayoutUtils.LayoutDynamicHeight(videoInfoRootView!)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if let subView : UIScrollView = myscr{
            subView.contentSize = videoInfoRootView!.frame.size
        }
    }
    
    
    
}
