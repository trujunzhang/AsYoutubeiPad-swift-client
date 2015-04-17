//
//  VideoInfoBlockUtils.m
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import <Nimbus/NICellCatalog.h>
#import "VideoInfoBlockUtils.h"

#import "NICellCatalog.h"

@implementation VideoInfoBlockUtils

+ (NICellDrawRectBlock)getVideoTitleDrawRectBlock {
    return ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {

        if(cell.isHighlighted || cell.isSelected) {
            [[UIColor clearColor] set];
        } else {
            [[UIColor whiteColor] set];
        }
        UIRectFill(rect);

        NSString *text = object;
        [[UIColor blackColor] set];
        UIFont *titleFont = [UIFont boldSystemFontOfSize:16];

        CGFloat titleWidth = rect.size.width - 400;

        // We're drawing variable height cells in this example to show how the table view smoothly
        // animates between the two very different states of the table view.
        CGSize size = [text sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        if(nil != cell) {
            [text drawInRect:CGRectMake(10, 5, size.width, size.height) withFont:titleFont lineBreakMode:NSLineBreakByWordWrapping];
        }

        CGFloat aFloat = size.height;
        return aFloat + 200;
    };
}



+ (NICellDrawRectBlock)getVideoOtherDrawRectBlock {
    return ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
        return 0;
    };
}
@end
