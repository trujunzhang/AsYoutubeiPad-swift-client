//
//  RequestFailureViewController.swift
//  app
//
//  Created by djzhang on 5/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Cartography

class RequestFailureViewController: UIViewController {
    
    // MARK: Layout Panel
    func layoutPanel(){
        layout(self.view) {
            view1 in
            
            view1.leading == view1.superview!.leading
            view1.trailing == view1.superview!.trailing
            
            view1.top == view1.superview!.top + 40
            view1.height == 60
        }
    }
}