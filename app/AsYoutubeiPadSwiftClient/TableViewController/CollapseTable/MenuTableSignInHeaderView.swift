//
//  MenuTableSignInHeaderView.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/28/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class MenuTableSignInHeaderView: UIViewController {
    
    @IBOutlet var eventButton: UIImageView!
    
    var _nodeCellSize: CGSize?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _nodeCellSize = CGSizeMake(REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
        
        self.layoutUserProfileUI()
        
        self.view.frame = CGRectMake(0, 0, REAR_VIEW_WIDTH, TABLE_HEADER_VIEW_HEIGHT)
    }
    
    
    override func viewWillLayoutSubviews() {
        
    }
    
    
    func layoutUserProfileUI() {
        
    }
    
}