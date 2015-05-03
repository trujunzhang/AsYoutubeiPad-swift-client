//
//  YTVideosCollectionViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/1/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import UIKit

class YTVideosCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!

    lazy var flowLayout: UICollectionViewFlowLayout = {
        var flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0)
        return flow
    }()

    var delegate: FetchEventProtocol?

    var refreshControl: UIRefreshControl!

    var videoList: NSMutableArray = NSMutableArray()


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Mark :
    override func viewDidLoad() {
        super.viewDidLoad()

        self.flowLayout.itemSize = CGSizeMake(214, 200)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.collectionView.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)

        self.collectionView.bounces = true
        // If your collectionview has a content size big enough to scroll vertically, it's OK, but in your case it's not.
        self.collectionView.alwaysBounceVertical = true

        // infinite scroll view for collection view
        self.collectionView.infiniteScrollIndicatorStyle = .Gray;
        registerInfiniteScrollView()

        self.setupRefreshViewController()

        insertRowAtTop()
    }

    func setupRefreshViewController() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "endRefreshingRefreshControl", forControlEvents: UIControlEvents.ValueChanged)

        self.collectionView.addSubview(refreshControl)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.startFetchedAnimation()
    }

    func startFetchedAnimation() {
        self.refreshControl.beginRefreshing()
    }

    func stopFetchedAnimation() {
        self.refreshControl.endRefreshing()
        self.collectionView.finishInfiniteScroll()
    }

    // MARK: UIRefreshControl' target
    func endRefreshingRefreshControl() {
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

        // 2. update collection view
        self.videoList.addObjectsFromArray(array as [AnyObject])
        self.collectionView.reloadData()

        // 1. stop animation
        self.stopFetchedAnimation()

        // 3. check next fetcher
        if (self.delegate!.hasNextFetcing() == false) {
            self.collectionView.removeInfiniteScroll()
        }
    }

    // Mark : delegate of UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let width: CGFloat = self.view.bounds.size.width * 0.98;
        let height: CGFloat = 150.0;

        return CGSizeMake(width, height)
    }

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