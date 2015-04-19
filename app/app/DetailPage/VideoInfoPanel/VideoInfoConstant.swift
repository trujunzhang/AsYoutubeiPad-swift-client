//
//  VideoInfoConstant.swift
//  app
//
//  Created by djzhang on 4/19/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

let VIDEO_INFO_TITLE_PANEL_HEIGHT: CGFloat = 60
let VIDEO_INFO_BACKGROUND_COLOR = "f1f1f1"

class TableAnimateObject {
    var maxValue: CGFloat?
    var minValue: CGFloat?
    var fromValue: CGFloat?

    init(_maxValue: CGFloat) {
        maxValue = _maxValue
    }

}