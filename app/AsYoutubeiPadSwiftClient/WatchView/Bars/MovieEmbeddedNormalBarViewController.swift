//
//  MovieEmbeddedNormalBarViewController.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 4/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class MovieEmbeddedNormalBarViewController: UIViewController {
    
    // MARK : top bar views
    @IBOutlet var topBarPanel: UIView!
    
    // MARK : bottom bar views
    @IBOutlet var bottomBarPanel: UIView!
//    normalBottomBarView?.frame = CGRectMake(0, 0, 576, 43)
    
    // MARK : bottom bar items
    
    @IBOutlet var durationSlider: UISlider!
    @IBOutlet var timeElapsedLabel: UILabel!
    @IBOutlet var timeRemainingLabel: UILabel!
    @IBOutlet var cancelButton: UIImageView!
    @IBOutlet var fullscreenButton: UIImageView!
    
    
    override func viewDidLoad() {
        let view : UIView = bottomBarPanel

    }
    
    override func viewDidLayoutSubviews() {

    }

}




