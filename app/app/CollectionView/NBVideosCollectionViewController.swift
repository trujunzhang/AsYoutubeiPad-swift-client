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

                self.requestInfo.appendArray(array)

            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // create NICellFactory instance
        cellFactory = NICollectionViewCellFactory()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK : model
    func makeModel(tableContents: [AnyObject]) -> NIMutableCollectionViewModel {
        let model: NIMutableCollectionViewModel = NIMutableCollectionViewModel(listArray: tableContents, delegate: cellFactory)

        return model
    }


}