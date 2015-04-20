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

class TableAnimateObject :NSObject {
    var maxValue: CGFloat?
    var minValue: CGFloat = VIDEO_INFO_TITLE_PANEL_HEIGHT

    var fromValue: CGFloat?

    init(_maxValue: CGFloat) {
        maxValue = _maxValue
    }
    
    func prepareAnimate(open : Bool){
        if(open == true){
            fromValue = maxValue;
        }else{
            fromValue = minValue;
        }

    }

}