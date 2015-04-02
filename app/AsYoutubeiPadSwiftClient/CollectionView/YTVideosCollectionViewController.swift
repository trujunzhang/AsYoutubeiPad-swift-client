//
//  YTVideosCollectionViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class YTVideosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var requestInfo: GYoutubeRequestInfo?

    override init() {
        super.init()

        requestInfo = GYoutubeRequestInfo()
//        YoutubeFetcher.search()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Mark :
    override func viewDidLoad() {

    }

    // Mark : delegate of UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let array = requestInfo?.videoList
//        return array?.count!
        
        return 0
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        var cell: YTVideoCollectionViewCell?

        return cell!
    }



    // Mark : delegate of UICollectionViewDelegate

}