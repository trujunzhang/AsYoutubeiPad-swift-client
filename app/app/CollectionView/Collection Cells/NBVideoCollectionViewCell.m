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

#import "NBVideoCollectionViewCell.h"
#import "YoutubeVideoCache.h"

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

    return YES;
}

@end
