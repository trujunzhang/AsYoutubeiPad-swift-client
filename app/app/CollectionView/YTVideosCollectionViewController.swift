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

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var delegate: FetchEventProtocol?

    var videoList: NSMutableArray = NSMutableArray()

    //    func makeRequestTask123() {
    //      let  requestInfo = AuthoredFetcher.sharedInstance.prepareFetchingActivityListOnHomePage({
    //            (object, sucess) -> Void in
    //            if (sucess == true) {
    //                var array: NSArray = object as! NSArray
    //
    //                var length = array.count
    //
    //                println("Length is \(length)")
    //
    //                self.requestInfo.appendArray(array)
    //
    //                self.collectionView.reloadData()
    //            }
    //        })
    //    }

    //    func makeRequestTask() {
    //        requestInfo = YoutubeFetcher.prepareRequestSearch("Sketch 3", completeHandler: {
    //            (object, sucess) -> Void in
    //            if (sucess == true) {
    //                var array: NSArray = object as! NSArray
    //
    //                var length = array.count
    //
    //                self.requestInfo.appendArray(array)
    //
    //                self.collectionView.reloadData()
    //            }
    //        })
    //    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Mark :
    override func viewDidLoad() {
        super.viewDidLoad()

        self.flowLayout.itemSize = CGSizeMake(214, 200)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        if let theCollectionView: UICollectionView = self.collectionView {
            theCollectionView.contentInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0)
            theCollectionView.backgroundColor = UIColor.clearColor()

            registerInfiniteScrollView()
        }

        insertRowAtTop()
    }

    func insertRowAtTop() {
        self.cleanupFetchedArray()

        self.delegate!.refreshEvent({
            (response, sucess) -> Void in

            self.appendFetchedArray(response as! NSArray)
        })
    }

    func insertRowAtBottom() {
        self.delegate!.nextFetching({
            (response, sucess) -> Void in

            self.appendFetchedArray(response as! NSArray)
        })
    }

    func registerInfiniteScrollView() {
        self.collectionView.addInfiniteScrollWithHandler({
            (collectionView) -> Void in
            self.insertRowAtBottom()
        })
    }

    func cleanupFetchedArray() {
        self.videoList = NSMutableArray()
        self.collectionView.reloadData()
    }

    func appendFetchedArray(array: NSArray) {
        // 1. stop animation
        self.stopFetchedAnimation()

        // 2. update collection view
        self.videoList.addObjectsFromArray(array as [AnyObject])
        self.collectionView.reloadData()

        // 3. check next fetcher
        if (self.delegate!.hasNextFetcing() == false) {
            self.collectionView.removeInfiniteScroll()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.startFetchedAnimation()
    }

    func startFetchedAnimation() {
        if let theCollectionView: UICollectionView = self.collectionView {
            //            theCollectionView.triggerPullToRefresh()
        }
    }

    func stopFetchedAnimation() {
        if let theCollectionView: UICollectionView = self.collectionView {
            theCollectionView.finishInfiniteScroll()
        }
    }


    // Mark : delegate of UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoList.count
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: YTVideoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("YTVideoCollectionViewCell", forIndexPath: indexPath) as! YTVideoCollectionViewCell

        let videoCache: YoutubeVideoCache = videoList[indexPath.row] as! YoutubeVideoCache
        cell.setupCell(videoCache)

        return cell
    }



    //MARK: UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoCache: YoutubeVideoCache = videoList[indexPath.row] as! YoutubeVideoCache
        let videoId: NSString = YoutubeParser.getWatchVideoId(videoCache)

        RevealViewHelper.sharedInstance.pushWatchVideoViewController(videoId)
    }

}