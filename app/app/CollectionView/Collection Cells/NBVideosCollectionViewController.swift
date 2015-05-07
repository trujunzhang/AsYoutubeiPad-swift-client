//
//  NBVideosCollectionViewController.swift
//  app
//
//  Created by djzhang on 5/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class NBVideosCollectionViewController: NBMultableCollectionBaseViewController {
    // MARK: Public ViewControllers
    lazy var loadingViewController:LoadingViewController = {
        return LoadingViewController.instance()
        }()
    lazy var requestFailureViewController:RequestFailureViewController = {
        return RequestFailureViewController.instance()
        }()
    
    
    private var delegate: FetchEventProtocol?
    private var eventObject: AnyObject?
    
    var videoList: NSMutableArray = NSMutableArray()
    
    lazy var refreshControl: UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "endRefreshingRefreshControl", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
        }()
    
    func setCollectionTask(eventObject: AnyObject,delegate: FetchEventProtocol){
        self.eventObject = eventObject
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE)
        
        self.registerInfiniteScrollView()
        self.insertLoadingViewPanel()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        insertRowAtTop()
    }
    
    func insertLoadingViewPanel(){
        self.addChildViewController(loadingViewController)
        self.view.addSubview(loadingViewController.view)
        loadingViewController.layoutPanel()
    }
    
    func insertRequestFailureViewPanel(){
        self.addChildViewController(requestFailureViewController)
        self.view.addSubview(requestFailureViewController.view)
        loadingViewController.layoutPanel()
    }
    
    func registerInfiniteScrollView() {
        self.collectionView!.addInfiniteScrollWithHandler({
            (collectionView) -> Void in
            self.insertRowAtBottom()
        })
    }
    
    
    func insertRowAtTop() {
        self.showLoadingPanel()
        self.cleanupFetchedArray()
        
        self.delegate!.refreshEvent(eventObject!, completeHandler: {
            (response, sucess) -> Void in
            
            if(sucess == true){
                self.hideLoadingPanel()
                self.appendFetchedArray(response as! NSArray)
            }else{
                self.insertRequestFailureViewPanel()
            }
        })
    }
    
    func insertRowAtBottom() {
        self.delegate!.nextFetching(eventObject!, completeHandler: {
            (response, sucess) -> Void in
            
            if(sucess == true){
                self.appendFetchedArray(response as! NSArray)
            }else{
                self.insertRequestFailureViewPanel()
            }
        })
    }
    
    func cleanupFetchedArray() {
        self.videoList = NSMutableArray()
        self.resetModel([])
    }
    
    func appendFetchedArray(array: NSArray) {
        let lastCount = self.videoList.count
        // 2. update collection view
        self.videoList.addObjectsFromArray(array as [AnyObject])
        
        if (lastCount == 0) {
            self.resetModel(array as [AnyObject])
        } else {
            self.appendContents(array as [AnyObject])
        }
        
        // 1. stop animation
        //                        self.stopFetchedAnimation()
        
        // 3. check next fetcher
        if (self.delegate!.hasNextFetcing() == false) {
            self.collectionView!.removeInfiniteScroll()
        }
    }
    
    func batchUpdateCollectionView(newCount: Int) {
        var resultsSize = self.videoList.count - newCount
        
        var arrayWithIndexPaths = NSMutableArray()
        for (var i = 0; i < newCount; i++) {
            println("arrayWithIndexPaths is :\(i+resultsSize)")
            arrayWithIndexPaths.addObject(NSIndexPath(forRow: i + resultsSize, inSection: 0))
        }
        
        self.collectionView!.performBatchUpdates({
            self.collectionView!.insertItemsAtIndexPaths(arrayWithIndexPaths as [AnyObject])
            },
            completion: nil)
    }
    
    func showLoadingPanel() {
        loadingViewController.showLoadingPanel()
        
        refreshControl.removeFromSuperview()
    }
    
    func hideLoadingPanel() {
        loadingViewController.hideLoadingPanel()
        
        self.collectionView!.addSubview(refreshControl)
    }
    
    // MARK: UIRefreshControl' target
    func endRefreshingRefreshControl() {
        self.refreshControl.endRefreshing()
        insertRowAtTop()
    }
    
    
}