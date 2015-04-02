//
// Created by djzhang on 12/14/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

//<track
// id="0" 
// name=""
// lang_code="en"
// lang_original="English"
// lang_translated="English"
// lang_default="true"
// cantran="true"
// />

@interface MABYT3_Track : NSObject

@property (strong, nonatomic) NSString *kind;

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lang_code;
@property (strong, nonatomic) NSString *lang_original;
@property (strong, nonatomic) NSString *lang_translated;
@property (nonatomic) BOOL lang_default;
@property (strong, nonatomic) NSString *cantran;

- (id)initFromDictionary:(NSDictionary *)dict withKind:(NSString *)kind;
@end