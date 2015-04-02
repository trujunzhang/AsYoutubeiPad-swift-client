//
//  SYSubtitleItem.m
//  TranscriptToSRT
//
//  Created by rominet on 12/11/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//


//-> MWFeedParser (1.0.1)
//An RSS and Atom web feed parser for iOS.
//pod 'MWFeedParser', '~> 1.0.1'
//- Homepage: https://github.com/mwaterfall/MWFeedParser
//- Source:   https://github.com/mwaterfall/MWFeedParser.git
//- Versions: 1.0.1, 1.0.0, 0.0.1 [master repo]
//- Sub specs:
//- MWFeedParser/FeedParser (1.0.1)
//- MWFeedParser/NSString+HTML (1.0.1)
//- MWFeedParser/NSDate+InternetDateTime (1.0.1)

#import "SYSubtitleItem.h"
#import "NSString+Time.h"
#import "NSString+XMLEntities.h"

@implementation SYSubtitleItem

- (instancetype)initWithXMLDic:(NSDictionary *)xmlDic {
    self = [super init];
    if(self) {
        self.startTime = xmlDic[@"_start"];
        self.duration = xmlDic[@"_dur"];
        self.text = xmlDic[@"__text"];

        self.text = [self.text stringByDecodingXMLEntities];
    }
    return self;
}

- (NSString *)srtStringWithItemNumber:(NSUInteger)itemNumber {
    NSMutableString *string = [NSMutableString string];

    if(itemNumber > 0)
        [string appendFormat:@"%ld\n", itemNumber];

    [string appendFormat:@"%@ --> %@\n", [self startTimeString], [self endTimeString]];
    [string appendFormat:@"%@\n\n", self.text];

    return [string copy];
}

- (NSString *)startTimeString {
    return [NSString stringForTimeFormattedForSeconds:[self.startTime doubleValue]];
}

- (NSString *)durationString {
    return [NSString stringForTimeFormattedForSeconds:[self.duration doubleValue]];
}

- (NSString *)endTimeString {
    return [NSString stringForTimeFormattedForSeconds:[self.startTime doubleValue] + [self.duration doubleValue]];
}

- (NSString *)description {
    return [self srtStringWithItemNumber:0];
}

@end
