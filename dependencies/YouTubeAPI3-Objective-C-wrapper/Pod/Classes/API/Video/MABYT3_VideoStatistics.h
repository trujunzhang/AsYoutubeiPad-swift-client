//
//  MABYT3_VideoStatistics.h
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 5/3/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MABYT3_VideoStatistics : NSObject


// The number of comments for the detailVideo.
@property (retain) NSNumber *commentCount;  // unsignedLongLongValue

// The number of users who have indicated that they disliked the detailVideo by giving
// it a negative rating.
@property (retain) NSNumber *dislikeCount;  // unsignedLongLongValue

// The number of users who currently have the detailVideo marked as a favorite detailVideo.
@property (retain) NSNumber *favoriteCount;  // unsignedLongLongValue

// The number of users who have indicated that they liked the detailVideo by giving it
// a positive rating.
@property (retain) NSNumber *likeCount;  // unsignedLongLongValue

// The number of times the detailVideo has been viewed.
@property (retain) NSNumber *viewCount;  // unsignedLongLongValue

- (id)initFromDictionary:(NSDictionary *)dict;

@end
