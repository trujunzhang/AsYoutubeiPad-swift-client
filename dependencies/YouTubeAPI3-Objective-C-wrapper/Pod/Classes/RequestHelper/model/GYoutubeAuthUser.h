//
//  Search.h
//  IOSTemplate
//
//  Created by djzhang on 9/25/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GYoutubeAuthUser : NSObject {

}

@property (nonatomic, strong) id channel;

- (NSArray *)getTableRows:(NSArray *)subscriptionsList;

@end
