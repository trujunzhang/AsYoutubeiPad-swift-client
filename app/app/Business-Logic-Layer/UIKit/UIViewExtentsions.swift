//
//  UIViewExtentions.swift
//
//  Created by Taro Minowa on 6/9/14.
//  Copyright (c) 2014 Higepon Taro Minowa. All rights reserved.
//

import UIKit
import Cartography

extension UIView {
    func centerHorizontally(parentWidth: CGFloat) {
        let centerX = CGFloat(floor(Double(CGFloat(parentWidth - frame.size.width) / CGFloat(2.0))))
        self.frame = CGRect(x:centerX, y:frame.origin.y, width:frame.size.width, height:frame.size.height)
    }
    

    /**
    AutoLayout for margining self
    
    :param: edge
    */
    func LayoutMargining(edge: UIEdgeInsets) {
        layout(self) {
            view1 in
            
            view1.leading == view1.superview!.leading + edge.left
            view1.trailing == view1.superview!.trailing - edge.right
            
            view1.top == view1.superview!.top + edge.top
            view1.bottom == view1.superview!.bottom - edge.bottom
        }
    }
    
    func layoutPanelTopMarginAndHeight(topMargin: CGFloat,height:CGFloat){
        layout(self) {
            view1 in
            
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            
            view1.top == view1.superview!.top + topMargin
            view1.height == height
        }
    }
}
