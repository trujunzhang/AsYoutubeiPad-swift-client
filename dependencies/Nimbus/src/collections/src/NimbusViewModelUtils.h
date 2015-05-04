//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NICollectionViewModel;
@class NIMutableCollectionViewModel;
@class NITableViewModel;
@class NIMutableTableViewModel;


@interface NimbusViewModelUtils : NSObject

+ (NITableViewModel *)makeNITableViewModel:(NSArray *)contents;

+ (NIMutableTableViewModel *)makeNIMutableTableViewModel:(NSArray *)contents;

+ (NICollectionViewModel *)makeNICollectionViewModel:(NSArray *)collectionContents;

+ (NIMutableCollectionViewModel *)makeNIMutableCollectionViewModel:(NSArray *)collectionContents;
@end