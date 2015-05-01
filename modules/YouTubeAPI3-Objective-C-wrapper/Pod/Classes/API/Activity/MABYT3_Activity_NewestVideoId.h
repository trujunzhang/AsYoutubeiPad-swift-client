//
// Created by djzhang on 5/1/15.
// Copyright (c) 2015 Nimbus. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MABYT3_Activity_NewestVideoId : NSObject


@property (strong, nonatomic) NSString *kind;
@property (strong, nonatomic) NSString *etag;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *publishedAt;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *videoId;

@property(nonatomic) BOOL containUpload;

- (id)initFromDictionary:(NSDictionary *)dict;
@end