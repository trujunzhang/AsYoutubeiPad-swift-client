//
//  YoutubeVideoCache.m
//  IOSTemplate
//
//  Created by djzhang on 11/17/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeVideoCache.h"
#import "YoutubeParser.h"


@interface YoutubeVideoCache () {
}
@end


@implementation YoutubeVideoCache


- (void)parseDescriptionString {
    if(self.descriptionStringAttributeArray == nil)
        [YoutubeParser parseDescriptionStringWithRegExp:self];
}

@end
