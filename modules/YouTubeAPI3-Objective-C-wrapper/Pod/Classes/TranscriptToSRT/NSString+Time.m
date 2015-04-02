//
//  NSString+Time.m
//  TranscriptToSRT
//
//  Created by rominet on 12/11/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+ (NSString *)stringForTimeFormattedForSeconds:(double)amount {
    double milliseconds = (amount - floor(amount)) * 1000.;
    amount = floor(amount);

    double seconds = (int)amount % 60;
    amount -= seconds;

    double minutes = (int)(amount / 60) % 60;
    amount -= minutes * 60;

    double hours = amount / 3600;

    return [NSString stringWithFormat:@"%02d:%02d:%02d,%03d",
                                      (int)hours,
                                      (int)minutes,
                                      (int)seconds,
                                      (int)milliseconds];
}

@end
