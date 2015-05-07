//
//  WatchVideoViewController.swift
//  appBDDApp
//
//  Created by djzhang on 5/7/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class WatchVideoViewController: UIViewController {
    
    @IBOutlet weak var playerViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playerViewContainer: UIView!    
    @IBOutlet weak var videoInfoContainer: UIView!
    @IBOutlet weak var suggestionContainer: UIView!
    
    override func viewDidLayoutSubviews() {
        let rectWidth = self.view.frame.size.width
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            //landscape
            playerViewWidthConstraint.constant = rectWidth/3*2
        } else {
            // portraight
            playerViewWidthConstraint.constant = rectWidth
        }
    }
}