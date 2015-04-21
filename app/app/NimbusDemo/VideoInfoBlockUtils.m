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
#import "VideoInfoObject.h"

CGFloat TITLE_HEIGHT = 60.0;
CGFloat DESCRIPTION_MARGIN_LEFT_RIGHT = 60.0;
CGFloat DESCRIPTION_MARGIN_TOP_BOTTOM = 60.0;

@implementation VideoInfoBlockUtils

#pragma mark - get rect block for video title

+ (NICellDrawRectBlock)getVideoTitleDrawRectBlock {
    return ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {

        if(cell.isHighlighted || cell.isSelected) {
            [[UIColor clearColor] set];
        } else {
            [[UIColor whiteColor] set];
        }
        UIRectFill(rect);

        VideoInfoObject *infoObject = object;
        // 1
        [self makeVideoTitle:infoObject withCell:cell withRect:rect];

        // 2
//        NSString *description = infoObject.descriptionString;
//        [[UIColor blackColor] set];
//        UIFont *titleFont = [UIFont boldSystemFontOfSize:16];
//
//        CGFloat titleWidth = rect.size.width- DESCRIPTION_MARGIN_LEFT_RIGHT*2;

        // We're drawing variable height cells in this example to show how the table view smoothly
        // animates between the two very different states of the table view.
//        CGSize size = [description sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//        if(nil != cell) {
//            [description drawInRect:CGRectMake(DESCRIPTION_MARGIN_LEFT_RIGHT, DESCRIPTION_MARGIN_TOP_BOTTOM + TITLE_HEIGHT, size.width, size.height) withFont:titleFont lineBreakMode:NSLineBreakByWordWrapping];
//        }

//        CGFloat aFloat = size.height + DESCRIPTION_MARGIN_TOP_BOTTOM *2;
        return 100;
    };
}

+ (void)makeVideoTitle:(VideoInfoObject *)infoObject withCell:(UITableViewCell *)cell withRect:(CGRect)rect {
    // 1
//    NSString *title = infoObject.title;
//    [[UIColor blackColor] set];
//    UIFont *titleFont = [UIFont boldSystemFontOfSize:14];
//
//    CGFloat titleWidth = rect.size.width;

    // We're drawing variable height cells in this example to show how the table view smoothly
    // animates between the two very different states of the table view.
//    CGSize titleSize = [title sizeWithFont:titleFont constrainedToSize:CGSizeMake(titleWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//    if(nil != cell) {
//        [title drawInRect:CGRectMake(10, 5, titleSize.width, titleSize.height) withFont:titleFont lineBreakMode:NSLineBreakByWordWrapping];
//    }

    // 2
//    NSString *likeCount = infoObject.likeCount;
//    [[UIColor blackColor] set];
//    UIFont *likeCountFont = [UIFont boldSystemFontOfSize:14];
//
//    CGFloat likeCountWidth = rect.size.width;

    // We're drawing variable height cells in this example to show how the table view smoothly
    // animates between the two very different states of the table view.
//    CGSize likeCountSize = [likeCount sizeWithFont:likeCountFont constrainedToSize:CGSizeMake(likeCountWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//    if(nil != cell) {
//        [likeCount drawInRect:CGRectMake(10, 5 + titleSize.height + 5, likeCountSize.width, likeCountSize.height) withFont:likeCountFont lineBreakMode:NSLineBreakByWordWrapping];
//    }

    // 3 right toggle button


}


#pragma mark - get rect block for video other (bottom position)

+ (NICellDrawRectBlock)getVideoOtherDrawRectBlock {
    return ^CGFloat(CGRect rect, id object, UITableViewCell *cell) {
        return 0;
    };
}
@end
