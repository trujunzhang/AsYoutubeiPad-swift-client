//
//  ASCacheNetworkImageNode.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncDisplayKit.h"

#import "CacheImageConstant.h"


@interface ASCacheNetworkImageNode : ASNetworkImageNode
- (instancetype)initForImageCache;

- (instancetype)initWithPlaceHolder:(UIImage *)placeHolder;

+ (instancetype)nodeWithPlaceHolderImage:(UIImage *)placeHolderImage;

+ (instancetype)nodeWithImageUrl:(NSString *)imageUrl;


- (void)startFetchImageWithString:(NSString *)urlString;

@end
