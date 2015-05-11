//
//  YTVideoWatchViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideoWatchViewController: UIViewController {
    
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sideViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playerViewContainer: UIView!
    @IBOutlet weak var videoInfoContainer: UIView!
    @IBOutlet weak var sideContainer: UIView!
    
    let searchTask : SearchTask = SearchTask()
    var videoInfoObject: VideoInfoObject = VideoInfoObject()
    
    var videoID: String = ""
    
    func fetchVideoInfo(){
        YoutubeFetcher.fetchVideoDescription(videoID, completeHandler: {
            (object, sucess) -> Void in
            
            if (sucess == true) {
                let array:NSArray = object as! NSArray
                if(array.count == 1){
                    //                    self.reloadTableData(array[0] as! YoutubeVideoCache)
                }
            }else{
                
            }
            
        })
    }
    
    
    lazy var videoInfoTableViewController : DetailPageTableViewController = {
        return DetailPageTableViewController.instance()
        }()
    
    lazy var sideTableViewController : DetailPageTableViewController = {
        return DetailPageTableViewController.instance()
        }()
    
    
    lazy var movieEmbeddedViewController: MovieEmbeddedViewController = {
        return MovieEmbeddedViewController.instance()
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize all containers
        makeMovieEmbeddedViewController()
        
        self.addChildViewController(videoInfoTableViewController)
        self.addChildViewController(sideTableViewController)
        
        
        // videoInfoTableViewController
        self.videoInfoContainer.addSubview(videoInfoTableViewController.view)
        LayoutUtils.LayoutFullView(videoInfoTableViewController.view)
        
        
        
        // sideTableViewController
        self.sideContainer.addSubview(sideTableViewController.view)
        LayoutUtils.LayoutFullView(sideTableViewController.view)
        
        // test
        self.searchTask.refreshEvent("sketch 3", completeHandler: {
            (response, sucess) -> Void in
            let array: NSArray = response as! NSArray
            self.sideTableViewController.appendSideVideos(array)
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let videoInfoObject: VideoInfoObject = VideoInfoObject()
        sideTableViewController.makeVideoInfoSection(videoInfoObject)
    }
    
    
    
    func makeMovieEmbeddedViewController() {
        movieEmbeddedViewController.videoID = videoID
        
        self.addChildViewController(movieEmbeddedViewController)
        self.playerViewContainer.addSubview(movieEmbeddedViewController.view)
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        func playerViewHeight(width:CGFloat) -> CGFloat {
            return width/16 * 9
        }
        
        let rectWidth = self.view.frame.size.width
        let rectHeight = self.view.frame.size.height
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            let playerWidth = rectWidth/3*2
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  rectWidth - playerWidth
            sideViewHeightConstraint.constant = rectHeight
            infoViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
        } else {
            // portraight
            let playerWidth = rectWidth
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  playerWidth
            sideViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
            infoViewHeightConstraint.constant = 0
        }
    }
    
    
    
    
    
    
}
