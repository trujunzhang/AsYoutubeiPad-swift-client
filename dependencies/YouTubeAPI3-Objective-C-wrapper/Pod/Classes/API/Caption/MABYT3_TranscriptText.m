//
// Created by djzhang on 12/14/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import "MABYT3_TranscriptText.h"


@implementation MABYT3_TranscriptText {

}


- (id)init {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcriptText";
        _identifier = @"";

    }
    return self;
}


//<text ="0.11" dur="1.34">Today I want to answer one of your questions</text>
- (id)initFromDictionary:(NSDictionary *)dict {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcriptText";
        _identifier = @"";
        _textValue = @"";

        if([dict objectForKey:@"id"]) {
            _identifier = [dict objectForKey:@"id"];
        }

        if([dict objectForKey:@"start"]) {
            _start = [dict objectForKey:@"start"];
        }
        if([dict objectForKey:@"dur"]) {
            _dur = [dict objectForKey:@"dur"];
        }

        if([dict objectForKey:@"leafContent"]) {
            _textValue = [dict objectForKey:@"leafContent"];
        }


    }
    return self;
}
@end