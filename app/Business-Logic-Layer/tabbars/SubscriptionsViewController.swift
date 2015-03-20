//
//  SubscriptionsViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/15/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import UIKit



class SubscriptionsViewController: UIViewController {
    
    
    var currentPhoto : LeftMenuSectionsUtils?
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        self.makeAsMenuTableViewController()
        
    }
    
    func makeAsMenuTableViewController(){
        
        var menuViewController:AsMenuTableViewController = AsMenuTableViewController()
        self.addChildViewController(menuViewController)
        
        var addView =  menuViewController.view;
        self.view.addSubview(addView)
        
        menuViewController.didMoveToParentViewController(self)
        
        
        addView.frame=self.view.bounds;
        
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
