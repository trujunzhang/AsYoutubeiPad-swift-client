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
        }

        //        self.view.backgroundColor = UIColor.yellowColor()
        //        self.collectionView.backgroundColor = UIColor.orangeColor()

        self.delegate!.refreshEvent({
            (response, sucess) -> Void in
            let array: NSArray = response as! NSArray
            self.appendFetchedArray(array)
        })
    }

    func appendFetchedArray(array: NSArray) {
        self.videoList.addObjectsFromArray(array as [AnyObject])
        self.collectionView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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