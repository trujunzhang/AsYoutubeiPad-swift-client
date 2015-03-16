//
//  MABYT3_LISTRequest.m
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 5/6/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import "MABYT3_APIRequest.h"

#import "GYoutubeRequestInfo.h"
#import "YoutubeResponseInfo.h"

#import "XMLDictionary.h"
#import "HCYoutubeParser.h"
#import "YoutubeConstants.h"
#import "MAB_GoogleUserCredentials.h"
#import "AFHTTPRequestOperation.h"
#import "MABYT3_ConvertTranscriptToSrt.h"


@implementation MABYT3_YoutubeRequest

- (NSMutableDictionary *)commonDictionary:(NSMutableDictionary *)parameters maxResultsString:(NSString *)maxResultsString {
    NSMutableDictionary *dictionary = [parameters mutableCopy];
    [dictionary setObject:apiKey forKey:@"key"];
    if(maxResultsString)
        [dictionary setObject:maxResultsString forKey:@"maxResults"];
    return dictionary;
}

- (NSError *)getError:(NSData *)data httpresp:(NSHTTPURLResponse *)httpresp {
    NSError *error;
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"error"]) {
        NSDictionary *dict2 = [dict objectForKey:@"error"];
        if([dict2 objectForKey:@"errors"]) {
            NSArray *items = [dict2 objectForKey:@"errors"];
            if(items.count > 0) {
                NSString *dom = @"YTAPI";
                if([items[0] objectForKey:@"domain"]) {
                    dom = [items[0] objectForKey:@"domain"];
                }
                error = [NSError errorWithDomain:dom
                                            code:httpresp.statusCode
                                        userInfo:items[0]];
            }
        }
    }
    return error;
}

@end


@implementation MABYT3_VideoGoogleRequest


+ (MABYT3_VideoGoogleRequest *)sharedInstance {
    static MABYT3_VideoGoogleRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://video.google.com/"];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"User-Agent" : @"APIs-Google"}];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[MABYT3_VideoGoogleRequest alloc] initWithBaseURL:baseURL
                                                      sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];

    });

    return _sharedClient;
}


//http://video.google.com/timedtext?type=list&tlangs=1&v=boBex_v3_eA
- (NSURLSessionDataTask *)fetchCaptainTracks:(NSString *)videoId completion:(MABYoutubeResponseBlock)completion {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    [dictionary setObject:videoId forKey:@"v"];
    [dictionary setObject:@"list" forKey:@"type"];
    [dictionary setObject:@"1" forKey:@"tlangs"];

    NSURLSessionDataTask *task = [self GET:@"/timedtext"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseVideoTranscriptListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


//http://video.google.com/timedtext?type=track&v=boBex_v3_eA&name=&lang=en
- (NSURLSessionDataTask *)fetchVideoTranscript:(NSString *)videoId completion:(MABYoutubeResponseBlock)completion {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    [dictionary setObject:videoId forKey:@"v"];
    [dictionary setObject:@"track" forKey:@"type"];
    [dictionary setObject:@"" forKey:@"name"];
    [dictionary setObject:@"en" forKey:@"lang"];

    NSURLSessionDataTask *task = [self GET:@"/timedtext"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseVideoTranscriptWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


#pragma mark -
#pragma mark


- (YoutubeResponseInfo *)parseVideoTranscriptListWithData:(NSData *)data {
    XMLDictionaryParser *parser = [[XMLDictionaryParser alloc] init];
    NSDictionary *dict = [parser dictionaryWithData:data];

    MABYT3_TranscriptList *transcriptList = [[MABYT3_TranscriptList alloc] init];
    if(dict) {
        transcriptList = [[MABYT3_TranscriptList alloc] initFromDictionary:dict];
    }


    return [YoutubeResponseInfo infoWithArray:transcriptList.trackList pageToken:nil];
}


- (YoutubeResponseInfo *)parseVideoTranscriptWithData:(NSData *)data {
    XMLDictionaryParser *parser = [[XMLDictionaryParser alloc] init];
    NSDictionary *dict = [parser dictionaryWithData:data];

    NSString *convertToSrt = nil;

    if(dict && [dict objectForKey:@"text"]) {
        convertToSrt = [MABYT3_ConvertTranscriptToSrt convertToSrt:[dict objectForKey:@"text"]];
    }

    return [YoutubeResponseInfo infoWithSubtitleString:convertToSrt];
}


@end


@implementation MABYT3_GetVideoInfoRequest

//https://www.youtube.com/get_video_info?hl=en&video_id=MVt32qoyhi0&eurl=&el=embedded&gl=US&ps=default
+ (MABYT3_GetVideoInfoRequest *)sharedInstance {
    static MABYT3_GetVideoInfoRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://www.youtube.com/"];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"User-Agent" : @"APIs-Google"}];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[MABYT3_GetVideoInfoRequest alloc] initWithBaseURL:baseURL
                                                       sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];

    });

    return _sharedClient;
}


//https://www.youtube.com/get_video_info?hl=en&video_id=MVt32qoyhi0&eurl=&el=embedded&gl=US&ps=default
//http://www.youtube.com/get_video_info?video_id=82urkb3mJaQ
- (NSURLSessionDataTask *)fetchVideoInfoMetadata:(NSString *)videoId completion:(MABYoutubeResponseBlock)completion {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

    [dictionary setObject:videoId forKey:@"video_id"];

    NSURLSessionDataTask *task = [self GET:@"/get_video_info"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseVideoInfoMetadataWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


#pragma mark -
#pragma mark


- (YoutubeResponseInfo *)parseVideoInfoMetadataWithData:(NSData *)data {
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

//    NSMutableDictionary *parts = [responseString dictionaryFromQueryStringComponents];

    NSMutableDictionary *videoDictionary = [NSMutableDictionary dictionary];

//    if(parts) {
//
//        NSString *fmtStreamMapString = [[parts objectForKey:@"url_encoded_fmt_stream_map"] objectAtIndex:0];
//        NSArray *fmtStreamMapArray = [fmtStreamMapString componentsSeparatedByString:@","];
//
//        for (NSString *videoEncodedString in fmtStreamMapArray) {
//            NSMutableDictionary *videoComponents = [videoEncodedString dictionaryFromQueryStringComponents];
//            NSString *type = [[[videoComponents objectForKey:@"type"] objectAtIndex:0] stringByDecodingURLFormat];
//            NSString *signature = nil;
//            if([videoComponents objectForKey:@"sig"]) {
//                signature = [[videoComponents objectForKey:@"sig"] objectAtIndex:0];
//            }
//
//            if([type rangeOfString:@"mp4"].length > 0) {
//                NSString *url = [[[videoComponents objectForKey:@"url"] objectAtIndex:0] stringByDecodingURLFormat];
//                url = [NSString stringWithFormat:@"%@&signature=%@", url, signature];
//
//                NSString *quality = [[[videoComponents objectForKey:@"quality"] objectAtIndex:0] stringByDecodingURLFormat];
//
//                NSLog(@"Found detailVideo for quality: %@", quality);
//                [videoDictionary setObject:url forKey:quality];
//            }
//        }
//    }


    return [YoutubeResponseInfo infoWithVideoDictionary:videoDictionary];
}


@end


@implementation MABYT3_AutoCompleteRequest

+ (MABYT3_AutoCompleteRequest *)sharedInstance {
    static MABYT3_AutoCompleteRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://suggestqueries.google.com/"];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"User-Agent" : @"APIs-Google"}];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[MABYT3_AutoCompleteRequest alloc] initWithBaseURL:baseURL
                                                       sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });

    return _sharedClient;
}


- (NSURLSessionDataTask *)autoCompleteSuggestions:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    //@"http://suggestqueries.google.com
    // /complete/search?client=youtube&ds=yt&alt=json&q=%@
    NSURLSessionDataTask *task = [self GET:@"/complete/search"
                                parameters:parameters
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseSearchSuggestionList:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];


    return task;
}


- (NSMutableArray *)parseSearchSuggestionList:(NSData *)theData {
    NSString *newStr = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSString *pageToken;

    NSString *json = nil;
    NSScanner *scanner = [NSScanner scannerWithString:newStr];
    [scanner scanUpToString:@"[[" intoString:NULL]; // Scan to where the JSON begins
    [scanner scanUpToString:@"]]" intoString:&json];
    //The idea is to identify where the "real" JSON begins and ends.
    json = [NSString stringWithFormat:@"%@%@", json, @"]]"];

    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] //Push all the JSON autocomplete detail in to jsonObject array.
                                                          options:0 error:NULL];
    for (int i = 0;i != [jsonObject count];i++) {
        for (int j = 0;j != 1;j++) {
            [arr addObject:[[jsonObject objectAtIndex:i] objectAtIndex:j]];
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:pageToken];
}


@end


@implementation MABYT3_APIRequest

+ (MABYT3_APIRequest *)sharedInstance {
    static MABYT3_APIRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"https://www.googleapis.com/"];

        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        [config setHTTPAdditionalHeaders:@{@"User-Agent" : @"APIs-Google"}];

        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];

        [config setURLCache:cache];

        _sharedClient = [[MABYT3_APIRequest alloc] initWithBaseURL:baseURL
                                              sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
    });

    return _sharedClient;
}


- (NSString *)GuidedCategoriesURLforRegion:(NSString *)reg andLanguage:(NSString *)lang {

    if([lang isEqualToString:@""]) {
        return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/guideCategories?part=id,snippet&regionCode=%@",
                                          reg];
    }
    return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/guideCategories?part=id,snippet&hl=%@&regionCode=%@",
                                      lang,
                                      reg];
}


- (NSString *)LanguagesURLforLanguae:(NSString *)lang {

    if([lang isEqualToString:@""]) {
        return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nLanguages?part=id,snippet"];
    }
    return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nLanguages?part=id,snippet&hl=%@",
                                      lang];
}


- (NSString *)RegionsURLforLanguae:(NSString *)lang {

    if([lang isEqualToString:@""]) {
        return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nRegions?part=id,snippet"];
    }
    return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nRegions?part=id,snippet&hl=%@", lang];
}


- (NSString *)getParameterString:(NSDictionary *)params {
    NSString *paramS = @"";
    for (NSString *key in [params allKeys]) {
        paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
    }
    return paramS;
}


- (NSString *)ChannelSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max {

    NSString *paramS = @"";
    for (NSString *key in [params allKeys]) {
        paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
    }
    if(max != 5) {
        paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
    }
    return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&type=channel%@",
                                      term,
                                      paramS];
}


- (NSString *)PlayListSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max {

    NSString *paramS = @"";
    for (NSString *key in [params allKeys]) {
        paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
    }
    if(max != 5) {
        paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
    }
    return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&type=playlist%@",
                                      term,
                                      paramS];
}


- (void)LISTActivitiesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    __block NSString *nxtURLStr = @"";
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];
    [self appendAuthInfo:request];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_Activity *itm = [[MABYT3_Activity alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                                   if([dict objectForKey:@"nextPageToken"]) {
                                       NSString *pagetoken = [dict objectForKey:@"nextPageToken"];
//                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                       nxtURLStr = pagetoken;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
//                                  handler(arr, error, nxtURLStr);
                               });

                           }];
}


- (void)LISTChannelSectionsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];
    [self appendAuthInfo:request];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_ChannelSection *itm = [[MABYT3_ChannelSection alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(arr, error);
                               });

                           }];
}


- (void)LISTChannelsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];
    [self appendAuthInfo:request];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_Channel *itm = [[MABYT3_Channel alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(arr, error);
                               });

                           }];
}


- (void)LISTGuideCategoriesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_GuideCategory *itm = [[MABYT3_GuideCategory alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(arr, error);
                               });

                           }];
}


- (void)LISTLanguagesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_Language *itm = [[MABYT3_Language alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(arr, error);
                               });

                           }];
}


#pragma mark -
#pragma mark fetch youtube search


- (NSURLSessionDataTask *)LISTVideosForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:nil];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/videos"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseVideoListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (NSURLSessionDataTask *)LISTSubscriptionsForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion accessToken:(NSString *)accessToken {
    NSString *maxResultsString = [NSString stringWithFormat:@"%d", SUBSCRIPTION_LIST_MAX];
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:maxResultsString];

    [[MABYT3_APIRequest sharedInstance].requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken]
                                                forHTTPHeaderField:@"Authorization"];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/subscriptions"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseSubscriptionListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];

                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (NSURLSessionDataTask *)LISTChannelsThumbnailsForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    NSString *maxResultsString = [NSString stringWithFormat:@"%d", search_maxResults];
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:maxResultsString];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/channels"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseChannelListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (NSURLSessionDataTask *)LISTPlayListForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    NSString *maxResultsString = [NSString stringWithFormat:@"%d", search_maxResults];
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:maxResultsString];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/playlists"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parsePlayListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (NSURLSessionDataTask *)LISTActivitiesForURL:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    NSString *maxResultsString = [NSString stringWithFormat:@"%d", search_maxResults];
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:maxResultsString];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/activities"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseActivitiesListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (NSURLSessionDataTask *)searchForParameters:(NSMutableDictionary *)parameters completion:(MABYoutubeResponseBlock)completion {
    NSString *maxResultsString = [NSString stringWithFormat:@"%d", search_maxResults];
    NSMutableDictionary *dictionary = [self commonDictionary:parameters maxResultsString:maxResultsString];

    NSURLSessionDataTask *task = [self GET:@"/youtube/v3/search"
                                parameters:dictionary
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;

                                       if(httpResponse.statusCode == 200) {
                                           YoutubeResponseInfo *responseInfo = [self parseSearchListWithData:responseObject];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseInfo, nil);
                                           });
                                       } else {
                                           NSError *error = [self getError:responseObject httpresp:httpResponse];
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, error);
                                           });
                                       }

                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil, error);
                });
            }];

    return task;
}


- (void)fetchWithUrl:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {
    __block NSString *pageToken = nil;

    NSMutableURLRequest *request = [self getRequest:urlStr withAuth:NO];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    void (^completionBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id o) {
        NSError *error = nil;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        YoutubeResponseInfo *responseInfo = nil;
        if(operation.response.statusCode == 200) {

//          pageToken = [self parseSearchList:urlStr arr:array data:operation.responseData];

            responseInfo = [self parseSearchListWithData:operation.responseData];
        }
        else {
            error = [self getError:operation.responseData httpresp:operation.response];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            handler(responseInfo, error);
//           handler(array, error, pageToken);
        });
    };
    void (^failBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
//           handler(nil, error, nil);
        });
    };

    [operation setCompletionBlockWithSuccess:completionBlock failure:failBlock];
    [operation start];
}


#pragma mark -
#pragma mark -


- (NSMutableURLRequest *)getRequest:(NSString *)urlStr withAuth:(BOOL)auth {

    NSString *string = [NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey];

    NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"GET"];
    if(auth) {
        if([MAB_GoogleUserCredentials sharedInstance].signedin) {
            [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                         [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
           forHTTPHeaderField:@"Authorization"];
        }
    }
    return request;
}


- (NSString *)parseSearchList:(NSString *)urlStr arr:(NSMutableArray *)arr data:(NSData *)data {
    NSError *e = nil;
    NSString *pageToken;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_SearchItem *itm = [[MABYT3_SearchItem alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }
    if([dict objectForKey:@"nextPageToken"]) {
        pageToken = [dict objectForKey:@"nextPageToken"];
    }
    return pageToken;
}


- (void)LISTVideoCategoriesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

    [request setHTTPMethod:@"GET"];
    [self appendAuthInfo:request];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"items"]) {
                                       NSArray *items = [dict objectForKey:@"items"];
                                       if(items.count > 0) {
                                           for (int i = 0;i < items.count;i++) {
                                               MABYT3_VideoCategory *itm = [[MABYT3_VideoCategory alloc] initFromDictionary:items[i]];
                                               [arr addObject:itm];
                                           }
                                       }
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(arr, error);
                               });

                           }];
}


- (void)appendAuthInfo:(NSMutableURLRequest *)request {
    if([MAB_GoogleUserCredentials sharedInstance].signedin) {
        [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                     [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
       forHTTPHeaderField:@"Authorization"];
    }
}


- (void)LIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos/rate?id=%@&rating=like&key=%@",
                                                                    videoId,
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 204) {
                                   added = YES;
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)DISLIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos/rate?id=%@&rating=dislike&key=%@",
                                                                    videoId,
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 204) {
                                   added = YES;
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)INSERTSubscription:(NSString *)channelId andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"snippet\": {\"resourceId\": {\"channelId\": \"%@\",\"kind\": \"youtube#channel\"}}}",
                                                channelId];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)INSERTVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"snippet\": {\"playlistId\": \"%@\",\"resourceId\": {\"videoId\": \"%@\",\"kind\": \"youtube#detailVideo\"},\"position\": %@}}",
                                                playlistID,
                                                videoId,
                                                [@(pos) stringValue]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)INSERTPlayList:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, NSString *, BOOL))handler {

    __block NSString *identifier = @"";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"},\"status\": {\"privacyStatus\": \"%@\"}}",
                                                playlistTitle,
                                                desc,
                                                [self privacyStringFromStatus:status]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet,status&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"id"]) {
                                       identifier = [dict objectForKey:@"id"];
                                   }
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, identifier, added);
                               });

                           }];
}


- (void)INSERTPlayList:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, NSString *, BOOL))handler {

    __block NSString *identifier = @"";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"}}",
                                                playlistTitle,
                                                desc];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"id"]) {
                                       identifier = [dict objectForKey:@"id"];
                                   }
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, identifier, added);
                               });

                           }];
}


- (void)UPDATEPlayListItem:(NSString *)itemId withVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"playlistId\": \"%@\",\"resourceId\": {\"kind\": \"youtube#detailVideo\",\"videoId\": \"%@\"},\"position\": %@}}",
                                                itemId,
                                                playlistID,
                                                videoId,
                                                [@(pos) stringValue]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"},\"status\": {\"privacyStatus\": \"%@\"}}",
                                                playlistID,
                                                playlistTitle,
                                                desc,
                                                [self privacyStringFromStatus:status]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet,status&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"}}",
                                                playlistID,
                                                playlistTitle,
                                                desc];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];

    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&key=%@",
                                                                    apiKey]]];
    [request setHTTPMethod:@"PUT"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 200) {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"snippet"]) {
                                       added = YES;
                                   }
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)DELETEPlayListItem:(NSString *)itemId withHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?id=%@&key=%@",
                                                                    itemId,
                                                                    apiKey]]];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 204) {
                                   added = YES;
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)DELETEPlayList:(NSString *)playlistID withHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?id=%@&key=%@",
                                                                    playlistID,
                                                                    apiKey]]];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 204) {
                                   added = YES;
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (void)DELETESubscription:(NSString *)subscriptionId andHandler:(void (^)(NSError *, BOOL))handler {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/subscriptions?id=%@&key=%@",
                                                                    subscriptionId,
                                                                    apiKey]]];
    [request setHTTPMethod:@"DELETE"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                 [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
   forHTTPHeaderField:@"Authorization"];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {

                               BOOL added = NO;
                               NSHTTPURLResponse *httpresp = (NSHTTPURLResponse *)response;
                               if(httpresp.statusCode == 204) {
                                   added = YES;
                               }
                               else {
                                   NSError *e = nil;
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:NSJSONReadingMutableContainers
                                                                                          error:&e];
                                   if([dict objectForKey:@"error"]) {
                                       NSDictionary *dict2 = [dict objectForKey:@"error"];
                                       if([dict2 objectForKey:@"errors"]) {
                                           NSArray *items = [dict2 objectForKey:@"errors"];
                                           if(items.count > 0) {
                                               NSString *dom = @"YTAPI";
                                               if([items[0] objectForKey:@"domain"]) {
                                                   dom = [items[0] objectForKey:@"domain"];
                                               }
                                               error = [NSError errorWithDomain:dom
                                                                           code:httpresp.statusCode
                                                                       userInfo:items[0]];
                                           }
                                       }
                                   }
                               }
                               dispatch_async(dispatch_get_main_queue(), ^(void) {
                                   handler(error, added);
                               });

                           }];
}


- (NSString *)privacyStringFromStatus:(YTPrivacyStatus)prvStts {

    NSString *retVal = @"public";

    switch (prvStts) {
        case kYTPrivacyStatusPrivate:
            retVal = @"private";
            break;
        case kYTPrivacyStatusUnlisted:
            retVal = @"unlisted";
            break;
        default:
            break;
    }
    return retVal;
}


#pragma mark -
#pragma mark


- (NSString *)parsePageToken:(NSDictionary *)dict {
    NSString *pageToken = nil;
    if([dict objectForKey:@"nextPageToken"]) {
        pageToken = [dict objectForKey:@"nextPageToken"];
    }
    return pageToken;
}


#pragma mark -
#pragma mark parse msdata to model collect


- (YoutubeResponseInfo *)parseVideoListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];

    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                YTYouTubeVideoCache *itm = [[YTYouTubeVideoCache alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }
    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}


- (YoutubeResponseInfo *)parseSearchListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_SearchItem *itm = [[MABYT3_SearchItem alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}


- (YoutubeResponseInfo *)parseSubscriptionListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_Subscription *itm = [[MABYT3_Subscription alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}


- (YoutubeResponseInfo *)parseChannelListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_Channel *itm = [[MABYT3_Channel alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}


- (YoutubeResponseInfo *)parseActivitiesListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_Activity *itm = [[MABYT3_Activity alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}


- (YoutubeResponseInfo *)parsePlayListWithData:(NSData *)data {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSError *e = nil;

    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
    if([dict objectForKey:@"items"]) {
        NSArray *items = [dict objectForKey:@"items"];
        if(items.count > 0) {
            for (int i = 0;i < items.count;i++) {
                MABYT3_PlayList *itm = [[MABYT3_PlayList alloc] initFromDictionary:items[i]];
                [arr addObject:itm];
            }
        }
    }

    return [YoutubeResponseInfo infoWithArray:arr pageToken:[self parsePageToken:dict]];
}

#pragma mark - 
#pragma mark 


@end
