//
// Copyright 2011-2014 NimbusKit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NetworkBlockCellsViewController.h"
#import "NimbusCore.h"

#import "NimbusModels.h"
#import "NetworkDrawRectBlockCell.h"
#import "NICellCatalog.h"
#import "VideoInfoObject.h"
#import <pop/POP.h>

//
// What's going on in this file:
//
// This is a demo of rendering table view cells with network images using blocks. This demo creates
// a subclass of the NIDrawRectBlockCell and uses NINetworkImageView to download the image.
//
// You will find the following Nimbus features used:
//
// [networkimage]
// NINetworkImageView
//
// [models]
// NITableViewModel
// NICellFactory
// NIDrawRectBlockCell
// NIDrawRectBlockCellObject
//
// This controller requires the following frameworks:
//
// Foundation.framework
// UIKit.framework
//


CGFloat DEFAULT_ROW_HEIGHT = 60.0;

@interface NetworkBlockCellsViewController ()<UITableViewDelegate>
@property (nonatomic, retain) NITableViewModel *model;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


// We're going to override the default mapping of NIDrawRectBlockCellObject -> NIDrawRectBlockCell
// so that we can display our subclassed version of NIDrawRectBlockCell with network images.
// To do this we must create an instance of NICellFactory which we will be able to customize by
// adding explicit mappings which will be used in preference of the implicit ones denoted by the
// cell objects.
@property (nonatomic, retain) NICellFactory *cellFactory;
@end

@implementation NetworkBlockCellsViewController {
    VideoInfoObject *_videoInfoObject;
}


- (void)makeModel {

    NICellDrawRectBlock drawTextBlock = ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
//            if(cell.isHighlighted || cell.isSelected) {
//                [[UIColor clearColor] set];
//            } else {
//                [[UIColor redColor] set];
//            }
//            UIRectFill(rect);

        // We know that we're using a network cell here, so we can safely cast without checking.
//            NetworkDrawRectBlockCell *networkCell = (NetworkDrawRectBlockCell *)cell;

        CGFloat blockCellHeight = [NetworkDrawRectBlockCell getBlockCellHeight:object withWidth:rect.size.width];

        return blockCellHeight;
    };


    _videoInfoObject = [VideoInfoObject makeVideoInfoObject];
    self.obj = [NIDrawRectBlockCellObject objectWithBlock:drawTextBlock object:_videoInfoObject];
    NSMutableArray *tableContents =
            [NSMutableArray arrayWithObjects:

                    self.obj,
                    [NITitleCellObject objectWithTitle:@"This section has no header"],

                            nil];

    // Set up our explicit mapping of NIDrawRectBlockCellObject -> NetworkDrawRectBlockCell.
    _cellFactory = [[NICellFactory alloc] init];
    [_cellFactory mapObjectClass:[NIDrawRectBlockCellObject class]
                     toCellClass:[NetworkDrawRectBlockCell class]];

    // Notice that we're passing the _cellFactory instance rather than (id)[NICellFactory class]
    // now.
    _model = [[NITableViewModel alloc] initWithListArray:tableContents
//                delegate:(id)[NICellFactory class]];
                                                delegate:_cellFactory];

    // By tapping this button we'll add a new section to the model.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddButton:)];

}


- (void)didTapAddButton:(UIBarButtonItem *)buttonItem {
//    self.currentRowHeight -= 20;//self.specialRowHeight;
//
//    [self.tableView beginUpdates];
//    NSArray *reloadIndexPath = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [self.tableView reloadRowsAtIndexPaths:reloadIndexPath withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView endUpdates];

    NSString *debug = @"debug";

//    [self performAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeModel];
    self.tableView.dataSource = _model;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //    self.specialRowHeight = [NetworkDrawRectBlockCell heightForObject:self.obj atIndexPath:0 tableView:self.tableView];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    CGFloat blockCellHeight = [NetworkDrawRectBlockCell getBlockCellHeight:_videoInfoObject withWidth:self.tableView.frame.size.width];
    self.specialRowHeight = blockCellHeight;
    _videoInfoObject.currentRowHeight = self.specialRowHeight;

    CGRect rect = CGRectMake(20, 20, self.tableView.frame.size.width, self.specialRowHeight);
    _videoInfoObject.showRect = rect;

    NSString *debug = @"debug";
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    NSString *debug = @"debug";
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NIIsSupportedOrientation(toInterfaceOrientation);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return _videoInfoObject.currentRowHeight;
    }
    // We ask each block to calculate its size in order to create variable-height block cells.
    return 200;
}


- (void)performAnimation {

//    [self.popCircle pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];

    if(self.animated) {
        anim.toValue = @(20);
    } else {
        anim.toValue = @(20);
    }

    self.animated = !self.animated;

    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if(finished) {

//            [self performAnimation];
        }
    };

    [_videoInfoObject pop_addAnimation:anim forKey:@"Animation"];

}


@end
