//
//  YoutubeResponseInfo.h
//  IOSTemplate
//
//  Created by djzhang on 11/21/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YoutubeResponseInfo : NSObject

// video metadata
@property (nonatomic, strong) NSMutableDictionary *videoDictionary;

// subtitle
@property (nonatomic, strong) NSString *subtitleString;

// list
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, copy) NSString *pageToken;

- (instancetype)initWithArray:(NSMutableArray *)array pageToken:(NSString *)pageToken;

- (instancetype)initWithSubtitleString:(NSString *)subtitleString;

- (instancetype)initWithVideoDictionary:(NSMutableDictionary *)videoDictionary;

+ (instancetype)infoWithVideoDictionary:(NSMutableDictionary *)videoDictionary;

+ (instancetype)infoWithSubtitleString:(NSString *)subtitleString;

+ (instancetype)infoWithArray:(NSMutableArray *)array pageToken:(NSString *)pageToken;

@end
