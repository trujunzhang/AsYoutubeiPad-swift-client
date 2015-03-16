//
// Created by djzhang on 12/14/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import "MABYT3_Transcript.h"
#import "MABYT3_TranscriptText.h"


@implementation MABYT3_Transcript {

}


- (id)init {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcript";
        _identifier = @"";

        _textList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (id)initFromDictionary:(NSDictionary *)dict {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcript";
        _identifier = @"";

        _textList = [[NSMutableArray alloc] init];

        NSDictionary *targetsDict = [dict objectForKey:@"text"];
        for (NSDictionary *targetDict in targetsDict) {
            MABYT3_TranscriptText *track = [[MABYT3_TranscriptText alloc] initFromDictionary:targetDict];
            [_textList addObject:track];
        }

    }
    return self;
}

@end