//
// Created by djzhang on 5/6/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NBVideosCollectionViewController.h"
#import "NICollectionViewModel.h"
#import "NICollectionViewCellFactory.h"

#import "NimbusCollections.h"
#import "NimbusCore.h"
#import "NBVideoCollectionViewCell.h"

@interface NBVideosCollectionViewController ()

// A model exists through the lifetime of the controller.
@property(nonatomic, strong) NICollectionViewModel *model;

@end

@implementation NBVideosCollectionViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(216, 200);
    if ((self = [super initWithCollectionViewLayout:flowLayout])) {
        self.title = @"Nibs";

        NSArray *collectionContents =
                @[
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                ];

        _model = [[NICollectionViewModel alloc] initWithListArray:collectionContents
                                                         delegate:(id) [NICollectionViewCellFactory class]];
    }
    return self;
}

- (id)init {
    // UICollectionViewController doesn't implement its initializer chain as would be expected, so we
    // must forward init methods to -initWithCollectionViewLayout ourselves.
    return [self initWithCollectionViewLayout:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Only assign the collection view's data source after the view has loaded.
    // You must be careful when you call self.collectionView in general because it will call loadView
    // if the view has not been loaded yet.
    self.collectionView.dataSource = _model;
}


@end