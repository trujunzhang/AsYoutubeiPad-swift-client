//
//  PublicConstant.swift
//  app
//
//  Created by djzhang on 5/6/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

extension LoadingViewController {
    
    class func instance() -> LoadingViewController {
        
        return  UIStoryboard(name: "Public", bundle: nil).instantiateViewControllerWithIdentifier("LoadingViewController") as! LoadingViewController
    }
    
    
}
