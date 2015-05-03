//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTLDateTime;


@interface GTLYoutubeUtils : NSObject
+ (GTLDateTime *)getPublishedAfterAsGTLDateTime;

+ (NSString *)getPublishedAfter;
@end