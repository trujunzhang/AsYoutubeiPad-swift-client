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

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var delegate: FetchEventProtocol?

    var videoList: NSMutableArray = NSMutableArray()

    lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "endRefreshingRefreshControl", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Mark :
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        self.collectionView.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)

        // If your collectionview has a content size big enough to scroll vertically, it's OK, but in your case it's not.
        self.collectionView.alwaysBounceVertical = true

        // infinite scroll view for collection view
        self.collectionView.infiniteScrollIndicatorStyle = .Gray;

        self.flowLayout.sectionInset = UIEdgeInsetsMake(COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE)

        self.registerInfiniteScrollView()
        self.collectionView.addSubview(refreshControl)

        insertRowAtTop()
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.startFetchedAnimation()
//        self.insertRowAtTop() // test
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

        let width: CGFloat = self.view.bounds.size.width / 4 - (COLLECTION_CELL_INSET_VALUE * 2)
        let height: CGFloat = 240;

        return CGSizeMake(width, height)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoList.count
    }

    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: YTVideoCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("YTVideoCollectionViewCell", forIndexPath: indexPath) as! YTVideoCollectionViewCell

        cell.setupCell(videoList[indexPath.row] as! YoutubeVideoCache)

        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1).CGColor
        cell.layer.cornerRadius = 4
        cell.backgroundColor = UIColor.whiteColor()

        return cell
    }



    //MARK: UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoId: NSString = YoutubeParser.getWatchVideoId(videoList[indexPath.row] as! YoutubeVideoCache)

        RevealViewHelper.sharedInstance.pushWatchVideoViewController(videoId)
    }

}