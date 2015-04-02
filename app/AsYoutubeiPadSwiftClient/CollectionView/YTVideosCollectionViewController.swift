//
//  YTVideosCollectionViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var requestInfo: YTYoutubeRequestInfo?
    
    override init() {
        super.init()
        
        requestInfo = YoutubeFetcher.sharedInstance.prepareRequestSearch("Sketch 3", completeHandler: { (object, sucess) -> Void in
            
        })
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Mark :
    override func viewDidLoad() {
        
    }
    
    // Mark : delegate of UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var count:int  = requestInfo?.getVideoList().count
        
//        return requestInfo?.getVideoListCount()
        return 1
//        return count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: YTVideoCollectionViewCell?
        
        return cell!
    }
    
    
    
    // Mark : delegate of UICollectionViewDelegate
    
}