//
//  YoutubeAuthInfo.m
//  IOSTemplate
//
//  Created by djzhang on 11/2/14.
//  Copyright (c) 2014 djzhang. All rights reserved.
//

#import "YoutubeAuthInfo.h"


@implementation YoutubeAuthInfo

- (instancetype)init {
    self = [super init];
    if(self) {
        self.title = @"";
        self.email = @"";
        self.thumbnailUrl = @"";

        self.accessToken = @"";
        self.refreshToken = @"";
    }

    return self;
}


#pragma mark NSCoding


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.thumbnailUrl forKey:@"thumbnailUrl"];

    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.refreshToken forKey:@"refreshToken"];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.thumbnailUrl = [aDecoder decodeObjectForKey:@"thumbnailUrl"];

        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.refreshToken = [aDecoder decodeObjectForKey:@"refreshToken"];
    }
    return self;
}


+ (void)saveAuthAccessToken:(NSString *)token refreshToken:(NSString *)token1 {

}


- (void)readTokens {

}


@end
