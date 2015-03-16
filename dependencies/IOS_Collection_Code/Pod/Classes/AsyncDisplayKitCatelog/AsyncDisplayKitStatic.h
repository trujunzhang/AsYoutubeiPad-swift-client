//
//  ASCacheNetworkImageNode.h
//  IOSTemplate
//
//  Created by djzhang on 10/24/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>


@interface ASTextNode (custom)

+ (ASTextNode *)initWithAttributedString:(NSAttributedString *)attributedString;

+ (ASTextNode *)initWithAttributedString:(NSAttributedString *)attributedString withLinkAttributeNames:(NSArray *)linkAttributeNames;

@end


@interface ASImageNode (custom)

+ (ASImageNode *)initWithImageNamed:(NSString *)name;

@end

