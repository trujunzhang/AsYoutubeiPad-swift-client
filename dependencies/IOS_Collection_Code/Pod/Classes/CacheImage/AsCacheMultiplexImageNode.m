//
// Created by djzhang on 12/10/14.
// Copyright (c) 2014 Facebook. All rights reserved.
//

#import "AsCacheMultiplexImageNode.h"


@interface AsCacheMultiplexImageNode ()<ASMultiplexImageNodeDataSource> {
    NSMutableDictionary *_multiplexImageUrlDictionary;
}

@end


@implementation AsCacheMultiplexImageNode {

}

- (instancetype)initWithMultiplexImageUrlArray:(NSArray *)urlArray {
    self = [super initWithCache:nil downloader:[[ASBasicImageDownloader alloc] init]];
    if(self) {
        _multiplexImageUrlDictionary = [self multiplexImageUrlDictionary:urlArray];

        self.dataSource = self;

        // load low-quality images before high-quality images
        self.downloadsIntermediateImages = YES;

    }

    return self;
}


+ (instancetype)nodeWithImageUrlArray:(NSArray *)urlArray {
    AsCacheMultiplexImageNode *node = [[self alloc] initWithMultiplexImageUrlArray:urlArray];
    [node start];

    return node;
}


- (void)start {
    self.imageIdentifiers = nil;
    self.imageIdentifiers = @[@"best", @"medium", @"worst"]; // go!
}


#pragma mark -
#pragma mark ASMultiplexImageNode data source & delegate.


- (NSDictionary *)multiplexImageUrlDictionary:(NSArray *)imageUrlArray {
    return @{
            @"worst" : imageUrlArray[0],
            @"medium" : imageUrlArray[1],
            @"best" : imageUrlArray[2],
    };
}


- (NSURL *)multiplexImageNode:(ASMultiplexImageNode *)imageNode URLForImageIdentifier:(id)imageIdentifier {

    NSString *string = [_multiplexImageUrlDictionary objectForKey:imageIdentifier];

    return [NSURL URLWithString:string];
}


@end