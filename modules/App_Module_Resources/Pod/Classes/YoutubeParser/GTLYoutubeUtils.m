//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "GTLYoutubeUtils.h"
#import "GTLDateTime.h"


@implementation GTLYoutubeUtils {

}

/**
* "publishedAt": "2015-04-30T19:00:01.000Z",
*/
+ (GTLDateTime *)getPublishedAfterAsGTLDateTime {
    NSCalendar *cal = [NSCalendar currentCalendar];

    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];

//    [components setDay:([components day] - 7)];
    [components setDay:([components day] - 1)];
    NSDate *lastWeek = [cal dateFromComponents:components];

//    NSLog(@"lastWeek=%@", lastWeek);

    GTLDateTime *gtlDateTime = [GTLDateTime dateTimeWithDate:lastWeek timeZone:nil];

    return gtlDateTime;
}

+ (NSString *)getPublishedAfter {
    NSString *string = [self getPublishedAfterAsGTLDateTime].RFC3339String;

    return string;
}

+ (NSString *)getDateExample {

    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[[NSDate alloc] init]];

    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0]; //This variable should now be pointing at a date object that is the start of today (midnight);

    [components setHour:-24];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *yesterday = [cal dateByAddingComponents:components toDate:today options:0];

    components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];

    [components setDay:([components day] - ([components weekday] - 1))];
    NSDate *thisWeek = [cal dateFromComponents:components];

    [components setDay:([components day] - 7)];
    NSDate *lastWeek = [cal dateFromComponents:components];

    [components setDay:([components day] - ([components day] - 1))];
    NSDate *thisMonth = [cal dateFromComponents:components];

    [components setMonth:([components month] - 1)];
    NSDate *lastMonth = [cal dateFromComponents:components];

    NSLog(@"today=%@", today);
    NSLog(@"yesterday=%@", yesterday);
    NSLog(@"thisWeek=%@", thisWeek);
    NSLog(@"lastWeek=%@", lastWeek);
    NSLog(@"thisMonth=%@", thisMonth);
    NSLog(@"lastMonth=%@", lastMonth);
}
@end