//
// Copyright 2011-2014 Jeff Verkoeyen
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <WebImage/WebImage.h>
#import "NBVideoCollectionViewCell.h"
#import "YoutubeVideoCache.h"
#import "YoutubeParser.h"

@implementation NBVideoCollectionViewCellObject

+ (instancetype)objectWithVideoObject:(YoutubeVideoCache *)videoCache {
    NBVideoCollectionViewCellObject *object = [[[self class] alloc] init];
    object.videoCache = videoCache;
    return object;
}

#pragma mark - NICollectionViewNibCellObject

- (UINib *)collectionViewCellNib {
    return [UINib nibWithNibName:NSStringFromClass([NBVideoCollectionViewCell class]) bundle:nil];
}

@end

@implementation NBVideoCollectionViewCell


#pragma mark - NICollectionViewCell

- (BOOL)shouldUpdateCellWithObject:(NBVideoCollectionViewCellObject *)object {
    YoutubeVideoCache *videoCache = object.videoCache;

    NSString *videoTitle = [YoutubeParser getVideoSnippetTitle:videoCache];
    NSString *thumbnailUrl = [YoutubeParser getVideoSnippetThumbnails:videoCache];
    NSString *channelTitle = [YoutubeParser getVideoSnippetChannelTitle:videoCache];
    NSString *publishedAgo = [YoutubeParser getVideoSnippetChannelPublishedAt:videoCache];

    _titleLabel.text = videoTitle;
    _infoLabel.text = publishedAgo;
    _channelTitleLabel.text = channelTitle;

    [_thumbnailImage sd_setImageWithURL:[NSURL URLWithString:thumbnailUrl]
                       placeholderImage:[UIImage imageNamed:@"thumbnail_border"]
                                options:SDWebImageRefreshCached];

    return YES;
}

@end
