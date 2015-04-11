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
import Alamofire

class AsCacheDownloader:NSObject ,ASImageDownloaderProtocol{
    
    func downloadImageWithURL(URL: NSURL!, callbackQueue: dispatch_queue_t!, downloadProgressBlock: ((CGFloat) -> Void)!, completion: ((CGImage!, NSError!) -> Void)!) -> AnyObject! {
        
        // if no callback queue is supplied, run on the main thread
        if(callbackQueue == nil) {
          let  callbackQueue = dispatch_get_main_queue()
        }
        
//        if(downloadProgressBlock != nil) {
//            downloadProgressBlock(1.0);
//        }
        

        let cache :Cache<UIImage> = WebImageCache.SharedLeftMenuImageCache()
        let fetch:Fetch =   cache.fetch(URL: URL, formatName: "icons").onSuccess { image in
            // image will be a nice rounded icon
            dispatch_async(callbackQueue){
                var roundedImage:UIImage = image
                completion(roundedImage.CGImage, nil)
            }
        }
        
        
//        var fetch:Alamofire.Request = Alamofire.Manager.sharedInstance.request(.GET, URL).response() {
//            (_, _, data, _) in
//            
//            dispatch_async(callbackQueue){
//                
//                let image:UIImage = UIImage(data: data! as! NSData)!
//                
//                cache.set(value: image as! UIImage, key: URL.URLString)
//                
//                completion(image.CGImage, nil)
//            }
//        }

        return fetch
    }
    
    func cancelImageDownloadForIdentifier(downloadIdentifier: AnyObject!) {
//        var fetch: Fetch = downloadIdentifier! as! Fetch
        
    }
    
}