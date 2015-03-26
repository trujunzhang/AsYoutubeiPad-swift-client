//
//  AsCacheDownloader.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Haneke
import Toucan
//import WebImage

class AsCacheDownloader:NSObject ,ASImageDownloaderProtocol{
    
    func downloadImageWithURL(URL: NSURL!, callbackQueue: dispatch_queue_t!, downloadProgressBlock: ((CGFloat) -> Void)!, completion: ((CGImage!, NSError!) -> Void)!) -> AnyObject! {
        
        if(downloadProgressBlock != nil) {
            downloadProgressBlock(1.0);
        }
        
        let cache :Cache<UIImage> = WebImageCache.SharedLeftMenuImageCache()
        let fetch:Fetch =   cache.fetch(URL: URL, formatName: "icons").onSuccess { image in
            // image will be a nice rounded icon
            var roundedImage:UIImage = image
            completion(roundedImage.CGImage, nil)
        }

        return fetch
    }
    
    func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject!) {
//        var fetch: Fetch = downloadIdentifier! as Fetch
        
    }
    
}