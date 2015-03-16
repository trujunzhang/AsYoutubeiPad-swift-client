//
//  ASCacheNetworkImageNode.m
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//


#import "ASCacheNetworkImageNode.h"


@interface ASCacheNetworkImageNode ()<ASImageCacheProtocol, ASImageDownloaderProtocol> {

}

@end


@implementation ASCacheNetworkImageNode


+ (instancetype)nodeWithPlaceHolderImage:(UIImage *)placeHolderImage {
    ASCacheNetworkImageNode *node = [[self alloc] initWithPlaceHolder:placeHolderImage];

    return node;
}


+ (instancetype)nodeWithImageUrl:(NSString *)imageUrl {
    ASCacheNetworkImageNode *node = [[self alloc] initForImageCache];

    [node startFetchImageWithString:imageUrl];

    return node;
}


- (instancetype)initWithPlaceHolder:(UIImage *)placeHolder {
//   self = [super initWithCache:self downloader:self];
//   self = [super initWithCache:self downloader:[[ASBasicImageDownloader alloc] init]];
    self = [self initForImageCache];
    if(self) {
        self.defaultImage = placeHolder;
    }

    return self;
}


- (instancetype)initForImageCache {
    self = [super initWithCache:self downloader:self];
//   self = [super initWithCache:self downloader:[[ASBasicImageDownloader alloc] init]];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}


- (void)startFetchImageWithString:(NSString *)urlString {
    self.URL = [NSURL URLWithString:urlString];
}


#pragma mark -
#pragma mark ASImageCacheProtocol


- (void)fetchCachedImageWithURL:(NSURL *)URL
                  callbackQueue:(dispatch_queue_t)callbackQueue
                     completion:(void (^)(CGImageRef imageFromCache))completion {
    // if no callback queue is supplied, run on the main thread
    if(callbackQueue == nil) {
        callbackQueue = dispatch_get_main_queue();
    }

    // ASMultiplexImageNode callbacks
    dispatch_async(callbackQueue, ^{
        if(completion) {
            UIImage *cacheImage = [YTCacheImplement getCacheImageWithURL:URL];
            completion([cacheImage CGImage]);
        }
    });

}


#pragma mark -
#pragma mark ASImageDownloaderProtocol


- (id)downloadImageWithURL:(NSURL *)URL
             callbackQueue:(dispatch_queue_t)callbackQueue
     downloadProgressBlock:(void (^)(CGFloat progress))downloadProgressBlock
                completion:(void (^)(CGImageRef image, NSError *error))completion {
    // if no callback queue is supplied, run on the main thread
    if(callbackQueue == nil) {
        callbackQueue = dispatch_get_main_queue();
    }

    void (^downloadCompletion)(UIImage *) = ^(UIImage *downloadedImage) {
        // ASMultiplexImageNode callbacks
        dispatch_async(callbackQueue, ^{
            if(downloadProgressBlock) {
                downloadProgressBlock(1.0f);
            }

            if(completion) {
                if(downloadedImage)
                    completion([downloadedImage CGImage], nil);
            }
        });
    };
    id imageOperation = [YTCacheImplement CacheWithUrl:URL withCompletionBlock:downloadCompletion];

    return imageOperation;
}


- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier {
//   NSLog(@"%s", sel_getName(_cmd));
    [YTCacheImplement cancelDowning:downloadIdentifier];
}


@end
