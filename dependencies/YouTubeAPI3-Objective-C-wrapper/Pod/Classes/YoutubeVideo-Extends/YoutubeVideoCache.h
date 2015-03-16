//
//  YTGridMoreCellNode.h
//  IOSTemplate
//
//  Created by djzhang on 11/17/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "YoutubeConstants.h"


@interface YoutubeVideoCache : MABYT3_Video

@property (nonatomic, strong) NSMutableArray *descriptionStringAttributeArray;// YoutubeVideoDescriptionStringAttribute

- (void)parseDescriptionString;

@end
