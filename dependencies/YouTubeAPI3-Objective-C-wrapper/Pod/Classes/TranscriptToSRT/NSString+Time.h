//
//  NSString+Time.h
//  TranscriptToSRT
//
//  Created by rominet on 12/11/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

+ (NSString *)stringForTimeFormattedForSeconds:(double)amount;

@end
