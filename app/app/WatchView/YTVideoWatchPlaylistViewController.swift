//
//  YTVideoWatchPlaylistViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/3/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideoWatchPlaylistViewController : UIViewController {
    
    var videoID = ""
    
    var requestInfo = YTYoutubeRequestInfo()
    
    func makeRequestTask(){
        requestInfo = YoutubeFetcher.prepareFetchingRelativeVideos(videoID, completeHandler: { (object, sucess) -> Void in
            if(sucess == true){
                var array:NSArray = object as! NSArray
                
                var length = array.count
                
                self.requestInfo.appendArray(array)
                
//                self.collectionView.reloadData()
            }
        })
    }
    
    override func viewDidLoad() {
        
    }
    
}