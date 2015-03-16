//
// Created by djzhang on 12/10/14.
// Copyright (c) 2014 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "ASControlNode+Subclasses.h"
#import "ASDisplayNode+Subclasses.h"


@interface AsCacheMultiplexImageNode : ASMultiplexImageNode

- (instancetype)initWithMultiplexImageUrlArray:(NSArray *)urlArray;

+ (instancetype)nodeWithImageUrlArray:(NSArray *)urlArray;

@end