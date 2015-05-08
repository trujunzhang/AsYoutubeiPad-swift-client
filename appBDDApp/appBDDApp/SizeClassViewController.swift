//
//  SizeClassViewController.swift
//  appBDDApp
//
//  Created by djzhang on 5/8/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class SizeClassViewController : UIViewController {
    
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var sideViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLayoutSubviews() {
        func playerViewHeight(width:CGFloat) -> CGFloat {
            return width/16 * 9
        }
        
        let rectWidth = self.view.frame.size.width
        let rectHeight = self.view.frame.size.height
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            let playerWidth = rectWidth/3*2
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  rectWidth - playerWidth
            sideViewHeightConstraint.constant = rectHeight
            infoViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
        } else {
            // portraight
            let playerWidth = rectWidth
            playerViewWidthConstraint.constant = playerWidth
            sideViewWidthConstraint.constant =  playerWidth
            sideViewHeightConstraint.constant = rectHeight - playerViewHeight(playerWidth)
            infoViewHeightConstraint.constant = 0
        }
    }
    
}