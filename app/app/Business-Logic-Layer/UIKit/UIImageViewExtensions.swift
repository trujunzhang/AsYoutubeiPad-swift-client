//
//  UIImageViewExtensions.swift
//  app
//
//  Created by djzhang on 5/14/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import WebImage

extension UIImageView{
    
    func ext_setImageWithString(url:String){
        self.sd_setImageWithURL(NSURL(string: url), placeholderImage: nil, options: SDWebImageOptions.LowPriority)
    }
    
    func ext_setImageWithString(url:String,placeHolder: UIImage){
        self.sd_setImageWithURL(NSURL(string: url), placeholderImage: placeHolder, options: SDWebImageOptions.LowPriority)
    }
    
    func ext_setImageWithNSString(url:NSString){
        self.ext_setImageWithString(url as String)
    }
    
    func ext_setImageWithNSString(url:NSString,placeHolder: UIImage){
        self.ext_setImageWithString(url as String,placeHolder:placeHolder)
    }
    
    

    
}