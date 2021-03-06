//
//  LayoutUtils.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/7/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class LayoutUtils: NSObject {


    class func LayoutFullView(view: UIView) {
        layout(view) {
            view1 in

            view1.centerX == view1.superview!.centerX
            view1.centerY == view1.superview!.centerY

            view1.width == view1.superview!.width
            view1.height == view1.superview!.height
        }
    }
    
    class func LayoutLeftAndRightMargin(view: UIView, leftRightMargin: CGFloat) {
        layout(view) {
            view1 in
            
            view1.leading == view1.superview!.leading + leftRightMargin
            view1.trailing == view1.superview!.trailing - leftRightMargin
            
            view1.top == view1.superview!.top
            view1.bottom == view1.superview!.bottom
        }
    }


    class func LayoutTopMargin(view: UIView, topMargin: CGFloat) {
        layout(view) {
            view1 in

            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing

            view1.top == view1.superview!.top + topMargin
            view1.bottom == view1.superview!.bottom
        }
    }


}
