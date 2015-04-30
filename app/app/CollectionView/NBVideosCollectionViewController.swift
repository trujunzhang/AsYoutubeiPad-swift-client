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
    
      var requestInfo = YTYoutubeRequestInfo()

    func makeRequestTask() {
        requestInfo = YoutubeFetcher.sharedInstance.prepareFetchingActivityListOnHomePage({
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray

                var length = array.count

                println("Length is \(length)")

                self.requestInfo.appendArray(array)

//                self.collectionView.reloadData()
            }
        })
    }

    func makeRequestTask123() {
        requestInfo = YoutubeFetcher.sharedInstance.prepareRequestSearch("Sketch 3", completeHandler: {
            (object, sucess) -> Void in
            if (sucess == true) {
                var array: NSArray = object as! NSArray

                var length = array.count

                self.requestInfo.appendArray(array)

//                self.collectionView.reloadData()
            }
        })
    }
}