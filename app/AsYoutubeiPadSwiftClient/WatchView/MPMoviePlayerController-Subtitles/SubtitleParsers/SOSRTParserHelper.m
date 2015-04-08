//
// Created by djzhang on 1/16/15.
// Copyright (c) 2015 djzhang. All rights reserved.
//

#import "SOSRTParserHelper.h"
#import "SOSubtitle.h"
#import <Bolts/Bolts.h>
#import "SOSubtitleItem.h"


@implementation SOSRTParserHelper {

}
- (void)parseSRTString:(NSString *)string toDictionary:(NSMutableDictionary *)subtitlesParts parsed:(void (^)(BOOL parsed, NSError *error))completion {
    SOSubtitle *soSubtitle = [[SOSubtitle alloc] init];
    BFTask *task = [soSubtitle subtitleWithString:string error:NULL];
    if(task.error) {
        completion(NO, task.error);
        return;
    }

    SOSubtitle *resultSubtitle = [task result];
    NSMutableArray *array = [resultSubtitle subtitleItems];

    [self convertArray:array toDictionary:subtitlesParts];
    NSString *debug = @"debug";
//    completion(NO, nil);
    completion(YES, nil);
}

- (void)convertArray:(NSMutableArray *)array toDictionary:(NSMutableDictionary *)subtitlesParts {

    int index = 1;
    for (SOSubtitleItem *subtitleItem in array) {
        double startTimeDouble = subtitleItem.startTimeDouble;
        double endTimeDouble = subtitleItem.endTimeDouble;
        NSString *textString = subtitleItem.text;

        NSString *indexString = [NSString stringWithFormat:@"%i", index];
        // Temp object
        NSTimeInterval startInterval = startTimeDouble;
        NSTimeInterval endInterval = endTimeDouble;
        NSDictionary *tempInterval = @{
                kIndex : indexString,
                kStart : @(startInterval),
                kEnd : @(endInterval),
                kText : textString ? textString : @""
        };
        [subtitlesParts setObject:tempInterval forKey:indexString];

        index++;
    }

//    NSArray *orderedKeys = [subtitlesParts keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSDictionary *tempInterval1 = obj1;
//        NSDictionary *tempInterval2 = obj2;
//        NSString *indexString1 = tempInterval1[kIndex];
//        NSString *indexString2 = tempInterval2[kIndex];
//        int v1 = [indexString1 intValue];
//        int v2 = [indexString2 intValue];
//        if(v1 < v2)
//            return NSOrderedAscending;
//        else if(v1 > v2)
//            return NSOrderedDescending;
//        else
//            return NSOrderedSame;
//    }];

    NSString *debug = @"debug";

}


@end