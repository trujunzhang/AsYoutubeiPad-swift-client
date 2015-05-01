//
//  NBVideosCollectionViewController.swift
//  app
//
//  Created by djzhang on 4/30/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Cartography

class NBVideosCollectionViewController: UIViewController {
    var model: NIMutableCollectionViewModel?
    var collectionView: UICollectionView?

    var cellFactory: NICollectionViewCellFactory?

    var requestInfo = YTYoutubeRequestInfo()


    func makeRequestTask() {
        requestInfo = YoutubeFetcher.sharedInstance.prepareRequestSearch("Sketch 3", completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray
                var length = array.count

                // Then reload tableview
                self.createSections(array)
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // create NICellFactory instance
        makeRequestTask()
        self.makeCollectionView()
        cellFactory = NICollectionViewCellFactory()
    }

    func makeCollectionView() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(214, 200)
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)

        if let theCollectionView: UICollectionView = collectionView {
            self.view.addSubview(theCollectionView)
            LayoutUtils.LayoutFullView(theCollectionView)
        }

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK : model
    func makeModel(collectionContents: [AnyObject]) -> NIMutableCollectionViewModel {
        let model: NIMutableCollectionViewModel = NIMutableCollectionViewModel(listArray: collectionContents, delegate: cellFactory)

        return model
    }

    // MARK: refresh collection

    func createSections(array: NSArray) {
        self.requestInfo.appendArray(array)

        let collectionContents: [AnyObject] = NBCollectionSectionGenerator.generatorSections(array)
        model = makeModel(collectionContents)

        reloadCollectionView(model!)
    }

    func reloadCollectionView(model: NIMutableCollectionViewModel) {
        if let theCollectionView: UICollectionView = collectionView {
            theCollectionView.dataSource = model
            theCollectionView.reloadData()
        }
    }

}