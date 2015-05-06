//
// Created by djzhang on 5/6/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import "NBMultableCollectionBaseViewController.h"
#import "NICollectionViewModel.h"
#import "NICollectionViewCellFactory.h"

#import "NimbusCollections.h"
#import "NimbusCore.h"
#import "NBVideoCollectionViewCell.h"

@interface NBMultableCollectionBaseViewController ()

// A model exists through the lifetime of the controller.
@property(nonatomic, strong) NIMutableCollectionViewModel *model;

@end

@implementation NBMultableCollectionBaseViewController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(216, 200);
    if ((self = [super initWithCollectionViewLayout:self.flowLayout])) {

        NSArray *collectionContents =
                @[
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                        [NBVideoCollectionViewCellObject objectWithTitle:@"Title 1"],
                ];

        _model = [[NIMutableCollectionViewModel alloc] initWithListArray:collectionContents
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