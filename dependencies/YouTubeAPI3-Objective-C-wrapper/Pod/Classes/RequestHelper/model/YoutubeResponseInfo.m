//
//  YoutubeResponseInfo.m
//  IOSTemplate
//
//  Created by djzhang on 11/21/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeResponseInfo.h"


@implementation YoutubeResponseInfo

#pragma mark -
#pragma mark default constructor


- (instancetype)init {
    self = [super init];
    if(self) {
        self.array = nil;
        self.pageToken = nil;
    }

    return self;
}


#pragma mark -
#pragma mark - constructor for video metadata


- (instancetype)initWithVideoDictionary:(NSMutableDictionary *)videoDictionary {
    self = [super init];
    if(self) {
        self.videoDictionary = videoDictionary;
    }

    return self;
}


+ (instancetype)infoWithVideoDictionary:(NSMutableDictionary *)videoDictionary {
    return [[self alloc] initWithVideoDictionary:videoDictionary];
}


#pragma mark -
#pragma mark - constructor for video subtitle


- (instancetype)initWithSubtitleString:(NSString *)subtitleString {
    self = [super init];
    if(self) {
        self.subtitleString = subtitleString;
    }

    return self;
}


+ (instancetype)infoWithSubtitleString:(NSString *)subtitleString {
    return [[self alloc] initWithSubtitleString:subtitleString];
}


#pragma mark -
#pragma mark constructor for Youtube api client v3


- (instancetype)initWithArray:(NSMutableArray *)array pageToken:(NSString *)pageToken {
    self = [super init];
    if(self) {
        self.array = array;
        self.pageToken = pageToken;
    }

    return self;
}


+ (instancetype)infoWithArray:(NSMutableArray *)array pageToken:(NSString *)pageToken {
    return [[self alloc] initWithArray:array pageToken:pageToken];
}


@end
