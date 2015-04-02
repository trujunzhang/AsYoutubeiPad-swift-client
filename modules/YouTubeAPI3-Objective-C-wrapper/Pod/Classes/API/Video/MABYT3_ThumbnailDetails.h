//
//  MABYT3_Video.h
//  YTAPI3Demo
//
//  Full Details : https://developers.google.com/youtube/v3/docs/videos#properties
//
//  Created by Muhammad Bassio on 5/3/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//



@class MABYT3_Thumbnail;


@interface MABYT3_ThumbnailDetails : NSObject

// The default image for this resource.
// Remapped to 'defaultProperty' to avoid language reserved word 'default'.
@property (retain) MABYT3_Thumbnail *defaultProperty;

// The high quality image for this resource.
@property (retain) MABYT3_Thumbnail *high;

// The maximum resolution quality image for this resource.
@property (retain) MABYT3_Thumbnail *maxres;

// The medium quality image for this resource.
@property (retain) MABYT3_Thumbnail *medium;

// The standard quality image for this resource.
@property (retain) MABYT3_Thumbnail *standard;


- (id)initFromDictionary:(NSDictionary *)dict;
@end
