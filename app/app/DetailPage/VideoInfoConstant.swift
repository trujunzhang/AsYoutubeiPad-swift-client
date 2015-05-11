//
//  VideoInfoConstant.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let VIDEO_INFO_TITLE_PANEL_HEIGHT: CGFloat = 120

let VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT: CGFloat = 20

let VIDEO_INFO_TOGGLE_WIDTH_HEIGHT: CGFloat = 39

typealias VideoToggleCompletionBlock = (AnyObject!, Bool!) -> Void

protocol VideoInfoToggleProtocol {
    func toggleVideoInfoPanel(completionBlock: VideoToggleCompletionBlock) -> Void
}

//extension VideoInfoViewController {
//    
//    class func instance() -> VideoInfoViewController {
//        
//        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("VideoInfoViewController") as! VideoInfoViewController
//    }
//}


extension DetailPageTableViewController {
    
    class func instance() -> DetailPageTableViewController {
        
        return UIStoryboard(name: STORYBOARD_VIDEOWATCH_NAME, bundle: nil).instantiateViewControllerWithIdentifier("DetailPageTableViewController") as! DetailPageTableViewController
    }
}


