//
//  VideoInfoConstant.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let VIDEO_INFO_TITLE_PANEL_HEIGHT: CGFloat = 60
let VIDEO_INFO_BACKGROUND_COLOR = "#fff1f1f1"

let VIDEO_INFO_TABLEVIEW_MARGIN_LEFT_RIGHT: CGFloat = 20

let VIDEO_INFO_TOGGLE_WIDTH_HEIGHT: CGFloat = 39

typealias VideoToggleCompletionBlock = (AnyObject!, Bool!) -> Void

protocol VideoInfoToggleProtocol {
    func toggleVideoInfoPanel(completionBlock:VideoToggleCompletionBlock) -> Bool
}
