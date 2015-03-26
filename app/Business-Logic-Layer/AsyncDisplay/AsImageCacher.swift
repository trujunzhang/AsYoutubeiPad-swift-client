//
//  AsCacheImage.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation

class AsImageCacher:NSObject, ASImageCacheProtocol {
    
    func fetchCachedImageWithURL(URL: NSURL!, callbackQueue: dispatch_queue_t!, completion: ((CGImage!) -> Void)!) {
        
        // if no callback queue is supplied, run on the main thread
        
        if(callbackQueue == nil) {
            let callbackQueue = dispatch_get_main_queue()
        }
        
        // ASMultiplexImageNode callbacks
        dispatch_async(callbackQueue, {
            if(completion != nil) {
                //                UIImage *cacheImage = [YTCacheImplement getCacheImageWithURL:URL];
                //                completion(cacheImage.CGImage);
                completion(nil)
            }
        });
        
        
    }
    
}