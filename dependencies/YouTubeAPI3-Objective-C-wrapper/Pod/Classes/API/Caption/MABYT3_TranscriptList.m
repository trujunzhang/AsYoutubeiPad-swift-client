//
// Created by djzhang on 12/14/14.
// Copyright (c) 2014 djzhang. All rights reserved.
//

#import "MABYT3_TranscriptList.h"
#import "MABYT3_Track.h"


@implementation MABYT3_TranscriptList {

}


- (id)init {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcript_list";
        _identifier = @"";

        _trackList = [[NSMutableArray alloc] init];

    }
    return self;
}


- (id)initFromDictionary:(NSDictionary *)dict {

    self = [super init];
    if(self) {
        _kind = @"youtube#transcript_list";
        _identifier = @"";

        _trackList = [[NSMutableArray alloc] init];

        if([dict objectForKey:@"_docid"]) {
            _identifier = [dict objectForKey:@"_docid"];
        }

        if([dict objectForKey:@"track"]) {
            MABYT3_Track *track = [[MABYT3_Track alloc] initFromDictionary:[dict objectForKey:@"track"]
                                                                  withKind:@"track"];
            [_trackList addObject:track];
        }
        if([dict objectForKey:@"target"]) {
            NSDictionary *targetsDict = [dict objectForKey:@"target"];
            for (NSDictionary *targetDict in targetsDict) {
                MABYT3_Track *track = [[MABYT3_Track alloc] initFromDictionary:targetDict withKind:@"target"];
                [_trackList addObject:track];
            }
        }

    }
    return self;
}

@end