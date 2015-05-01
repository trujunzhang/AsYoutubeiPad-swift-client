//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NimbusCollectionsUtils.h"
#import "NICollectionViewModel.h"
#import "NICollectionViewCellFactory.h"
#import "NIMutableCollectionViewModel.h"


@implementation NimbusCollectionsUtils {

}

+ (NICollectionViewModel *)makeNICollectionViewModel:(NSArray *)collectionContents {
    NICollectionViewModel *model = [[NICollectionViewModel alloc] initWithListArray:collectionContents
                                                                           delegate:(id) [NICollectionViewCellFactory class]];

    return model;
}

+ (NIMutableCollectionViewModel *)makeNIMutableCollectionViewModel:(NSArray *)collectionContents {
    NIMutableCollectionViewModel *model = [[NIMutableCollectionViewModel alloc] initWithListArray:collectionContents
                                                                                         delegate:(id) [NICollectionViewCellFactory class]];

    return model;
}

@end