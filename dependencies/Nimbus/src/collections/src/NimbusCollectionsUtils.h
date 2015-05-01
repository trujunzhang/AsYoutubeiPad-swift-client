//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NICollectionViewModel;
@class NIMutableCollectionViewModel;


@interface NimbusCollectionsUtils : NSObject

+ (NICollectionViewModel *)makeNICollectionViewModel:(NSArray *)collectionContents;

+ (NIMutableCollectionViewModel *)makeNIMutableCollectionViewModel:(NSArray *)collectionContents;
@end