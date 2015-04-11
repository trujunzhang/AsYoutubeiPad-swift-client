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


}


@end