//
//  SYSubtitleItem.h
//  TranscriptToSRT
//
//  Created by rominet on 12/11/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYSubtitleItem : NSObject

@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) NSString *text;

- (instancetype)initWithXMLDic:(NSDictionary *)xmlDic;

- (NSString *)srtStringWithItemNumber:(NSUInteger)itemNumber;

- (NSString *)startTimeString;

- (NSString *)durationString;

- (NSString *)endTimeString;

@end
