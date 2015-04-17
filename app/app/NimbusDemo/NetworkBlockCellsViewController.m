//
//  NetworkBlockCellsViewController.m
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import "NetworkBlockCellsViewController.h"
#import "NITableViewModel.h"
#import "VideoInfoTitleTableViewCell.h"

@interface NetworkBlockCellsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, retain) NITableViewModel *model;
@end

@implementation NetworkBlockCellsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self makeTableModel];

    self.tableView.dataSource = _model;
}

- (void)makeTableModel {
    NSArray* collectionContents =
            @[
                    [VideoInfoTitleTableViewCellObject objectWithTitle:@"Title 1"]
            ];

    _model = [[NITableViewModel alloc] initWithListArray:collectionContents
            delegate:(id)[NICellFactory class]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
