//
//  VideoInfoObject.m
//  app
//
//  Created by djzhang on 4/17/15.
//  Copyright (c) 2015 djzhang. All rights reserved.
//

#import "VideoInfoObject.h"

@implementation VideoInfoObject

- (instancetype)init {
    self = [super init];
    if(self) {
        self.title = @"WebStorm 10 - New features";
        self.likeCount = @"2,222 views";
        self.description = @"Trisha Gee, JetBrains Developer Advocate talks about new features in WebStorm 10. \n"
                "\n"
                "I don't know why it works and how Xcode detect which constraint is more prioritised (because I'm not set priority for these constraints explicity), but I'll be thankful if someone explain, why it works.\n"
                "\n"
                "When you want to align multiple elements, say three button in one vertical line, you'll have to set the above said additional constraints to the bottom most element. (example included)\n"
                "\n"
                "\n"
                "I've got a scrollview and inside it, an imageview in storyboard. I have iboutlets to the file this code is in with references to those views. They are called scrollView and graph respectively. I am trying to programmatically add a lot of UILabels below the graph inside the scrollview, but I can't even get one to show up.\n"
                "\n"
                "The width constraint I added doesn't cause any problems, but the other three constraints get runtime errors saying The view hierarchy is not prepared for the constraint. I want to constrain the top of the label to the bottom of the graph, the left of the label to the left of the scrollview, and the bottom of the label to the bottom of the scrollview. What am I doing wrong?\n"
                "\n"
                "I see different examples where constraints are set. Some set them in viewDidLoad / loadView (after the subview was added). Others set them in the method updateViewConstraints, which gets called by viewDidAppear.\n"
                "\n"
                "When I try setting constraints in updateViewContraints there can be a jumpiness to the layout, e.g. slight delay before the view appears. Also, if I use this method, should I clear out existing constraints first i.e. [self.view [removeConstraints:self.view.constraints]?\n"
                "\n"
                "Both -updateConstraints and -updateViewConstraints may be called multiple times during a view's lifetime. (Calling setNeedsUpdateConstraints on a view will trigger this to happen, for example.) As a result, you need to make sure to prevent creating and activating duplicate constraints -- either using a BOOL to only perform certain constraint setup only once, or by making sure to deactivate/remove existing constraints before creating & activating new ones.";
    }

    return self;
}

@end
