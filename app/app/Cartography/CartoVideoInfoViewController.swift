//
//  CartoVideoInfoViewController.swift
//  app
//
//  Created by djzhang on 4/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class CartoVideoInfoViewController: UIViewController {
    
    @IBOutlet weak var videoInfoContainer: UIView!
    
    var videoInfoViewController:YTVideoWatchInfoViewController?
    var videoInfoRootView : UIView?
    
    var myscr : UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createview()
        
        videoInfoViewController = WatchViewStoryboardUtils.getYTVideoWatchInfoViewController()
        
        if let controller : UIViewController = videoInfoViewController{
            self.addChildViewController(controller)
            
            videoInfoRootView = controller.view
        }
        
    }
    
    func createview(){
        myscr = UIScrollView()
        //        myscr!.frame = CGRectMake(0,0,300,300)
                myscr!.contentSize = CGSizeMake(300,300)
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
            
            if let subView : UIScrollView = myscr{
                subView.addSubview(videoInfoRootView!)
            }
            
        }
        
        LayoutDynamicHeight(videoInfoRootView!)
    }
    
    func LayoutDynamicHeight(view : UIView){
        layout(view) { view1 in
            
            view1.top == view1.superview!.top
            view1.leading == view1.superview!.leading
            view1.trailing  == view1.superview!.trailing
            
            //            view1.height  == 180
        }
    }
    
//    func LayoutForScroller(view : UIView){
//        layout(view) { view1 in
//            view1.leadingMargin ==  20
//            view1.trailingMargin ==  20
//            view1.topMargin ==  20
//            view1.bottomMargin ==  20
//            
////            view1.leading == view1.superview!.leading + 20
////            view1.trailing  == view1.superview!.trailing - 20
////            
////            view1.top == view1.superview!.top + 20
////            view1.bottom  == view1.superview!.bottom - 20
//            
//        }
//    }
    
    override func viewDidLayoutSubviews() {
        if let subView : UIScrollView = myscr{
//            subView.contentSize = videoInfoRootView!.frame.size
        }
    }
    
    
    
}
