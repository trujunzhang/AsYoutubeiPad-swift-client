//
//  VideoInfoTitleTableViewCell.m
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import "VideoInfoTitleTableViewCell.h"


@implementation VideoInfoTitleTableViewCellObject

+ (instancetype)objectWithTitle:(NSString *)title {
    VideoInfoTitleTableViewCellObject* object = [[[self class] alloc] init];
    object.title = title;
    return object;
}

#pragma mark - NINibCellObject

- (UINib *)cellNib{
    return [UINib nibWithNibName:NSStringFromClass([VideoInfoTitleTableViewCell class]) bundle:nil];
}


@end

@implementation VideoInfoTitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - NICell

- (BOOL)shouldUpdateCellWithObject:(id)object{

    return YES;
}

@end
