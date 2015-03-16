#if !defined YOUTUBECONSTANTS_H
#define YOUTUBECONSTANTS_H

//================================================================================================
// Google-client-api
//================================================================================================
#import "GTLYouTube_Sources.h"

#import "GTLUtilities.h"
#import "GTMHTTPUploadFetcher.h"
#import "GTMHTTPFetcherLogging.h"
#import "GTMOAuth2Authentication.h"
#import "GTMOAuth2ViewControllerTouch.h"



//================================================================================================
// YouTubeAPI3-Objective-C-wrapper
//================================================================================================
#import "MABYT3_APIRequest.h"

#import "MABYouTube_Sources.h"

// other
#import "YoutubeVideoCache.h"
#import "YoutubeVideoDescriptionStringAttribute.h"


// common
#import <AsyncDisplayKit/AsyncDisplayKit.h>


#endif


//#define hasShowLeftMenu NO
#define hasShowLeftMenu YES


#define SUBSCRIPTION_LIST_MAX 2
#define subscriptionIndex  0
//#define debugLeftMenuTapSubscription NO
//#define debugLeftMenuTapSubscription YES

#define debugCollectionViewToDetail  NO
//#define debugCollectionViewToDetail  YES

#define debugCollectionViewToDetail_local  NO
//#define debugCollectionViewToDetail_local  YES


// module

//#define YTYouTubeVideo  GTLYouTubeVideo
//#define YTYouTubeVideo  MABYT3_Video

#define YTYouTubeVideoCache  YoutubeVideoCache

#define YTYouTubePlayList  MABYT3_PlayList
#define YTYouTubePlaylistItem  GTLYouTubePlaylistItem

// Channel for author
#define YTYouTubeAuthorChannel  GTLYouTubeChannel

// Channel for other request
#define YTYouTubeChannel  MABYT3_Channel

//#if debugLeftMenuTapSubscription == YES
//#define YTYouTubeSubscription  MABYT3_Subscription
//#elif debugLeftMenuTapSubscription == NO
#define YTYouTubeSubscription  GTLYouTubeSubscription
//#endif

#define YTYouTubeMABThumbmail  MABYT3_Thumbnail

//
#define YTServiceYouTube  GTLServiceYouTube
#define YTOAuth2Authentication  GTMOAuth2Authentication

//
#define YTQueryYouTube  GTLQueryYouTube

// different
//#define YTYouTubeSearchResult  GTLYouTubeSearchResult
#define YTYouTubeSearchResult  MABYT3_SearchItem

#define YTYouTubeActivity  MABYT3_Activity
#define YTYouTubeActivityContentDetails  MABYT3_ActivityContentDetails
#define YTYouTubeResourceId  MABYT3_ResourceId


















