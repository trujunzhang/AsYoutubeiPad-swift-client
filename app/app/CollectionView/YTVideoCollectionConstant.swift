//
//  YTVideoCollectionConstants.swift
//  app
//
//  Created by djzhang on 4/29/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let COLLECTION_CELL_INSET_VALUE: CGFloat = 5.0
let COLLECTION_CELL_INFO_HEIGHT: CGFloat = 100

extension YTVideosCollectionViewController {

    class func instance() -> YTVideosCollectionViewController {

        return  UIStoryboard(name: "ReusedViewControllers", bundle: nil).instantiateViewControllerWithIdentifier("YTVideosCollectionViewController") as! YTVideosCollectionViewController

    }
}

//
//extension NBVideosCollectionViewController {
//    
//    class func instance() -> NBVideosCollectionViewController {
//
//        return NBVideosCollectionViewController()
//    }
//}

