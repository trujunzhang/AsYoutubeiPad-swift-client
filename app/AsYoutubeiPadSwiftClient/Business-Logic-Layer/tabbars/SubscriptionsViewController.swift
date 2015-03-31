//
//  SubscriptionsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit



class SubscriptionsViewController: FrontBaseViewController {
    
    
    var currentPhoto : LeftMenuSectionsUtils?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let channelPageViewController: ChannelPageViewController = ChannelPageViewController()
        
        channelPageViewController.view.frame = self.view.frame
        
        self.view.addSubview(channelPageViewController.view)
    }
    
    func test(){
        
        let button:UIButton = UIButton()
        button.setTitle("wanghao", forState: .Normal)
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.frame = CGRectMake(100, 100, 200, 44)
        
        //        self.view.addSubview(button)
        
        
        var tabBarItemsController: UIViewController =
        self.storyboard!.instantiateViewControllerWithIdentifier("YTTabBarItemsViewController") as UIViewController
        
        
        let headerView:UIView = UIView()
        headerView.frame = CGRectMake(0, 100, self.view.frame.size.width, 44)
        headerView.addSubview(tabBarItemsController.view)
        
        //        self.view.addSubview(headerView)
    }
    
    
    
    func fetchingData(){
        //        let AFHTTPManager = AFHTTPRequestOperationManager()
        //        AFHTTPManager.GET(
        //            "http://api.openweathermap.org/data/2.5/forecast/daily?q=atlanta&mode=json&units=metric&cnt=5",
        //            parameters: nil,
        //            success: {(operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        //                println("Data is : " + responseObject.description)
        ////                self.textxx!.text = responseObject.description
        //            },
        //            failure: { (operation: AFHTTPRequestOperation!,error: NSError!)in
        //                println("Error: " + error.localizedDescription)
        //        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
