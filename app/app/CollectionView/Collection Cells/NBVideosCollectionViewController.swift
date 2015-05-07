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
        
        self.flowLayout.sectionInset = UIEdgeInsetsMake(COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE, COLLECTION_CELL_INSET_VALUE)
        
        self.registerInfiniteScrollView()
        self.insertLoadingViewPanel()
        
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
            }
        })
    }
    
    func cleanupFetchedArray() {
        //        self.videoList = NSMutableArray()
        //        self.collectionView.reloadData()
    }
    
    func appendFetchedArray(array: NSArray) {
        let lastCount = self.videoList.count
        // 2. update collection view
        self.videoList.addObjectsFromArray(array as [AnyObject])
        
        self.appendContents(array as [AnyObject])
        
        // 1. stop animation
//                self.stopFetchedAnimation()
        
        // 3. check next fetcher
        if (self.delegate!.hasNextFetcing() == false) {
            self.collectionView!.removeInfiniteScroll()
        }
    }
    
    func showLoadingPanel() {
        loadingViewController.showLoadingPanel()
        
        refreshControl.removeFromSuperview()
    }
    
    func hideLoadingPanel() {
        loadingViewController.hideLoadingPanel()
        
        self.collectionView!.addSubview(refreshControl)
    }
    
    
}