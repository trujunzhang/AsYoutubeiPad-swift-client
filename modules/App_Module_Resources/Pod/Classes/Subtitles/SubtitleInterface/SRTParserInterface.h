#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SDSRTParserError) {
    SDSRTMissingIndexError,
    SDSRTCarriageReturnIndexError,
    SDSRTInvalidTimeError,
    SDSRTMissingTimeError,
    SDSRTMissingTimeBoundariesError
};


static NSString *const kIndex = @"kIndex";
static NSString *const kStart = @"kStart";
static NSString *const kEnd = @"kEnd";
static NSString *const kText = @"kText";

@interface SRTParserInterface : NSObject

- (void)parseSRTString:(NSString *)string toDictionary:(NSMutableDictionary *)subtitlesParts parsed:(void (^)(BOOL parsed, NSError *error))completion;

+ (NSString*)searchAndShowSubtitle:(NSMutableDictionary*)subtitlesParts inTime:(NSTimeInterval) currentPlaybackTime;
+ (void)searchAndShowSubtitle:(NSMutableDictionary*)subtitlesParts withLabel:(UILabel*)subtitleLabel inTime:(NSTimeInterval) currentPlaybackTime;

@end