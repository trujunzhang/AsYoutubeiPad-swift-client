//
//  VideoInfoTitleTableViewCell.h
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NICellFactory.h"

@interface VideoInfoTitleTableViewCellObject : NSObject <NINibCellObject>

+ (instancetype)objectWithTitle:(NSString *)title;

@property (nonatomic, copy) NSString* title;

@end

@interface VideoInfoTitleTableViewCell : UITableViewCell <NICell>

@end
