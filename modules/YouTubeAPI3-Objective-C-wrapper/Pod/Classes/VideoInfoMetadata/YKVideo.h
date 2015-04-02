//
//  YKVideo.h
//  YKMediaHelper
//
//  Created by Yas Kuraishi on 3/12/14.
//  Copyright (c) 2014 Yas Kuraishi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, YKQualityOptions) {
    YKQualityLow,
    YKQualityMedium,
    YKQualityHigh
};

@protocol YKVideo<NSObject>

@required

/**
This is a blocking call, wont return till detailVideo info has been parsed. To avoid blocking behavor, use init and call parseURL to parse detailVideo url
*/
- (instancetype)initWithContent:(NSURL *)contentURL;

/**
Loads detailVideo info and parses direct urls to detailVideo and thumbnail images
*/
- (void)parseWithCompletion:(void (^)(NSError *error))callback;

/**
Thumbnail image for given quality
*/
- (void)thumbImage:(YKQualityOptions)quality completion:(void (^)(UIImage *thumbImage, NSError *error))callback;

/**
Direct url to the detailVideo for given quality
*/
- (NSURL *)videoURL:(YKQualityOptions)quality;

/**
Plays detailVideo for a given quality in a modal window
*/
- (void)play:(YKQualityOptions)quality;

@optional

/**
Instance of player so you could present it modally by yourself or push it to a navigation controller.
*/
- (MPMoviePlayerViewController *)movieViewController:(YKQualityOptions)quality;

@end
