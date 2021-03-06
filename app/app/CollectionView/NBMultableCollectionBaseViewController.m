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

    }
    return self;
}

- (void)resetModel:(NSArray *)array {
    NSMutableArray *collectionContents = [[NSMutableArray alloc] init];
    for (id object in array) {
        YoutubeVideoCache *videoCache = object;
        [collectionContents addObject:[NBVideoCollectionViewCellObject objectWithVideoObject:videoCache]];
    }

    _model = [[NIMutableCollectionViewModel alloc] initWithListArray:collectionContents
                                                            delegate:(id) [NICollectionViewCellFactory class]];

    // Only assign the collection view's data source after the view has loaded.
    // You must be careful when you call self.collectionView in general because it will call loadView
    // if the view has not been loaded yet.
    self.collectionView.dataSource = _model;
}

- (id)init {
    // UICollectionViewController doesn't implement its initializer chain as would be expected, so we
    // must forward init methods to -initWithCollectionViewLayout ourselves.
    return [self initWithCollectionViewLayout:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

     [self.collectionView registerClass:[NBVideoCollectionViewCell class] forCellWithReuseIdentifier:@"NBVideoCollectionViewCellObject"];
}

- (void)viewDidAppear:(BOOL)animated {

}

- (void)appendContents:(NSArray *)array {
    // We first create a new section in the model.
    //    NSIndexSet* indexSet = [self.model addSectionWithTitle:[self randomName]];

    // Then we create an array of objects that we want to add to this section.
    NSMutableArray *objects = [NSMutableArray array];
    for (NSInteger ix = 0; ix < array.count; ++ix) {
        id object = [array objectAtIndex:ix];
        id cellObject = [NBVideoCollectionViewCellObject objectWithVideoObject:object];
        [objects addObject:cellObject];
    }

    // The result of adding these objects is an array of index paths that can be used to ensure the
    // visibility of the new objects.
    NSArray *indexPaths = [_model addObjectsFromArray:objects];

    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:indexPaths];

    }                             completion:nil];

    // Now that we've modified the model, we want to recompile the section index before notifying the
    // table view of changes to the model.
    //    [self.model updateSectionIndex];

    // Tell the table view that we've added a new section and that it should use the default
    // animation.
    //    [self.collectionView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    // Scroll the table view such that the last object is in view.
    //    [self.collectionView scrollToRowAtIndexPath:indexPaths.lastObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


@end