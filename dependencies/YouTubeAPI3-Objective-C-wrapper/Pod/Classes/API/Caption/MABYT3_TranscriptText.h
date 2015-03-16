//
// Created by djzhang on 12/14/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>


//<text start="0" dur="0.11" />
//<text start="0.11" dur="1.34">Today I want to answer one of your questions</text>
@interface MABYT3_TranscriptText : NSObject


@property (strong, nonatomic) NSString *kind;

@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *dur;
@property (strong, nonatomic) NSString *textValue;

- (id)initFromDictionary:(NSDictionary *)dict;
@end