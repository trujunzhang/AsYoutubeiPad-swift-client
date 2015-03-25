//
//  WebImageCache.swift
//  AsYoutubeiPadSwiftClient
//
//  Created by djzhang on 3/25/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

import Foundation
import Haneke

class WebImageCache: NSObject {
    class func SharedLeftMenuImageCache() -> Cache<UIImage>{
        let cache = Haneke.sharedImageCache
        
        let iconFormat = Format<UIImage>(name: "icons", diskCapacity: 10 * 1024 * 1024) { image in
            //return imageByRoundingCornersOfImage(image)
            return image
        }
        cache.addFormat(iconFormat)

        return cache
    }
}