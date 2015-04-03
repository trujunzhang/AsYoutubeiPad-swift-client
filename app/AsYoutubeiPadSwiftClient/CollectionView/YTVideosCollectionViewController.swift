//
//  YTVideosCollectionViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var requestInfo = YTYoutubeRequestInfo()
    
    override init() {
        super.init()

    }
    
    func makeRequestTask(){
        requestInfo = YoutubeFetcher.sharedInstance.prepareRequestSearch("Sketch 3", completeHandler: { (object, sucess) -> Void in
            if(sucess == true){
                var array:NSArray = object as NSArray
                
                var length = array.count
                
                self.requestInfo.appendArray(array)
                
                self.collectionView.reloadData()
            }
        })
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Mark :
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
//        self.view.backgroundColor = UIColor.yellowColor()
//        self.collectionView.backgroundColor = UIColor.orangeColor()
        
        makeRequestTask()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Mark : delegate of UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.requestInfo.getVideoListCount()
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:YTVideoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("YTVideoCollectionViewCell", forIndexPath: indexPath) as YTVideoCollectionViewCell
        
        let videoCache:YoutubeVideoCache = self.requestInfo.videoList[indexPath.row] as YoutubeVideoCache
        cell.setupCell(videoCache)
        
        return cell
    }
    
    
    
    // Mark : delegate of UICollectionViewDelegate
    
}