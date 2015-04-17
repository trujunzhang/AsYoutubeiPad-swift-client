//
//  VideoInfoBlockUtils.h
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoInfoBlockUtils : NSObject

+ (NICellDrawRectBlock)getVideoTitleDrawRectBlock;

+ (NICellDrawRectBlock)getVideoOtherDrawRectBlock;
@end
