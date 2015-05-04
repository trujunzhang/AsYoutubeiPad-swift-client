//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NimbusViewModelUtils.h"
#import "NICollectionViewModel.h"
#import "NICollectionViewCellFactory.h"
#import "NIMutableCollectionViewModel.h"
#import "NIMutableTableViewModel.h"
#import "NITableViewModel.h"
#import "NICellFactory.h"


@implementation NimbusViewModelUtils {

}

+ (NITableViewModel *)makeNITableViewModel:(NSArray *)contents {
    return [[NITableViewModel alloc] initWithListArray:contents
                                              delegate:(id) [NICellFactory class]];
}

+ (NIMutableTableViewModel *)makeNIMutableTableViewModel:(NSArray *)contents {
    return [[NIMutableTableViewModel alloc] initWithListArray:contents
                                                     delegate:(id) [NICellFactory class]];
}

+ (NICollectionViewModel *)makeNICollectionViewModel:(NSArray *)collectionContents {
    return [[NICollectionViewModel alloc] initWithListArray:collectionContents
                                                   delegate:(id) [NICollectionViewCellFactory class]];
}

+ (NIMutableCollectionViewModel *)makeNIMutableCollectionViewModel:(NSArray *)collectionContents {
    return [[NIMutableCollectionViewModel alloc] initWithListArray:collectionContents
                                                          delegate:(id) [NICollectionViewCellFactory class]];
}

@end