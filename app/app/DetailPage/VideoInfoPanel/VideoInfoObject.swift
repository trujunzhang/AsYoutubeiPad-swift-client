//
//  VideoInfoObject.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class VideoInfoObject: NSObject {

    var maxHeightValue: CGFloat = 0
    var minHeightValue: CGFloat = VIDEO_INFO_TITLE_PANEL_HEIGHT

    var descriptionWidth: CGFloat = 0

    var fromValue: CGFloat?

    func prepareAnimate(open: Bool) {
        if (open == true) {
            fromValue = maxHeightValue
        } else {
            fromValue = 0
        }
    }

    func setDescriptionMaxHeight(max: CGFloat, _descriptionWidth: CGFloat) {
        descriptionWidth = _descriptionWidth
        currentRowHeight = max
        maxHeightValue = max
    }

    var title = "WebStorm 10 - New features"
    var likeCount = "2,222 views"
    var descriptionString = "Both -updateConstraints and -updateViewConstraints may be called multiple times during a view's lifetime. (Calling setNeedsUpdateConstraints on a view will trigger this to happen, for example.) As a result, you need to make sure to prevent creating and activating duplicate constraints -- either using a BOOL to only perform certain constraint setup only once, or by making sure to deactivate/remove existing constraints before creating & activating new ones."


    var currentRowHeight: CGFloat = 0

}