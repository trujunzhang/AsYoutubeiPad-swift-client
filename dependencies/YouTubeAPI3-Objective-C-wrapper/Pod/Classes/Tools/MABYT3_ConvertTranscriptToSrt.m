//
// Created by djzhang on 12/15/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import "MABYT3_ConvertTranscriptToSrt.h"
#import "SYSubtitleItem.h"
#import "NSString+PJR.h"


@implementation MABYT3_ConvertTranscriptToSrt {
}


+ (NSString *)convertToSrt:(NSMutableArray *)subDics {
    NSString *subtitle = [[NSString alloc] init];

    NSMutableArray *subItems = [NSMutableArray arrayWithCapacity:[subDics count]];
    for (NSDictionary *subDic in subDics)
        [subItems addObject:[[SYSubtitleItem alloc] initWithXMLDic:subDic]];

    [subItems sortUsingComparator:^NSComparisonResult(SYSubtitleItem *obj1, SYSubtitleItem *obj2) {
        double start1 = [obj1.startTime doubleValue];
        double start2 = [obj2.startTime doubleValue];
        if(start1 == start2)
            return NSOrderedSame;
        return start1 < start2 ? NSOrderedAscending : NSOrderedDescending;
    }];

    for (NSUInteger i = 0;i < [subItems count];++i) {
        SYSubtitleItem *subItem = subItems[i];
        NSString *subString = [subItem srtStringWithItemNumber:i + 1];

        subtitle = [subtitle addString:subString];
    }

    return subtitle;
}


@end