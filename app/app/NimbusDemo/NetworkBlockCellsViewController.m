//
//  NetworkBlockCellsViewController.m
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import "NetworkBlockCellsViewController.h"
#import "NITableViewModel.h"
#import "NetworkDrawRectBlockCell.h"
#import "VideoInfoBlockUtils.h"
#import "VideoInfoObject.h"

@interface NetworkBlockCellsViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NITableViewModel *model;
@property (nonatomic, retain) NICellFactory *cellFactory;
@end

@implementation NetworkBlockCellsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self makeTableModel];

    self.tableView.dataSource = _model;
    self.tableView.delegate = self;
}

- (void)makeTableModel {
    NICellDrawRectBlock drawTextBlock = ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
        if(cell.isHighlighted || cell.isSelected) {
            [[UIColor clearColor] set];
        } else {
            [[UIColor whiteColor] set];
        }
        UIRectFill(rect);

        NSString *text = object;
        [[UIColor blackColor] set];
        UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
//      [text drawAtPoint:CGPointMake(10, 5) withFont:titleFont];

        CGFloat titleWidth = rect.size.width - 400;

        // We're drawing variable height cells in this example to show how the table view smoothly
        // animates between the two very different states of the table view.
        CGSize size = [text sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        if(nil != cell) {
            [text drawInRect:CGRectMake(10, 5, size.width, size.height) withFont:titleFont lineBreakMode:NSLineBreakByWordWrapping];
        }

        // We know that we're using a network cell here, so we can safely cast without checking.
        NetworkDrawRectBlockCell *networkCell = (NetworkDrawRectBlockCell *)cell;

        // Grab the image and then draw it on the cell. If there is no image yet then the draw method
        // will do nothing.
        UIImage *image = networkCell.networkImageView.image;
        [image drawAtPoint:CGPointMake(CGRectGetMaxX(rect) - image.size.width - 10, 5)];

        CGFloat aFloat = size.height;
        return aFloat + 200;
    };

    NICellDrawRectBlock videoTitleDrawRectBlock = [VideoInfoBlockUtils getVideoTitleDrawRectBlock];
    NICellDrawRectBlock videoOtherDrawRectBlock = [VideoInfoBlockUtils getVideoOtherDrawRectBlock ];

    NSMutableArray *tableContents =
            [NSMutableArray arrayWithObjects:
                    [NIDrawRectBlockCellObject objectWithBlock:videoTitleDrawRectBlock object:[VideoInfoObject makeVideoInfoObject]],
//                    [NIDrawRectBlockCellObject objectWithBlock:drawTextBlock object:@"c28f6b282ad61bff6aa9aba06c62ad66"],
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // We ask each block to calculate its size in order to create variable-height block cells.
    NIDrawRectBlockCellObject *object = [self.model objectAtIndexPath:indexPath];
    return object.block(self.tableView.bounds, object.object, nil);
}

@end
