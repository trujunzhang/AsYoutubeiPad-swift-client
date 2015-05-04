//
//  AutoCompleteSearchBar.m
//
//  Created by Matthew Ott on 2/27/15.
//

#import <YouTubeAPI3-Objective-C-wrapper/YoutubeResponseInfo.h>
#import "AutoCompleteSearchBar.h"
#import "MABYT3_APIRequest.h"

static NSString *autoCompleteCellIdentifier = @"AutoCompleteSearchBarCell";

@implementation AutoCompleteSearchBar

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    autoCompleteResults = @[];

    // Init AutoCompleteTableView
    [self setAutoCompleteTableView:[[UITableView alloc] initWithFrame:[self getAutoCompleteTableFrame]]];
    [self.autoCompleteTableView setDelegate:self];
    [self.autoCompleteTableView setDataSource:self];

    self.popoverController = [[UIPopoverController alloc] initWithContentViewController:self.autoCompleteTableView];

    // Add a gesture for dismissing the keyboard and AutoCompleteTable when tapping outside of the UITableViewCells.
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAutoCompleteView)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    // See gestureRecognizerShouldBegin method for details.
    tapGestureRecognizer.delegate = self;
    [self.autoCompleteTableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)dealloc {
    [self.autoCompleteTableView removeFromSuperview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return autoCompleteResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:autoCompleteCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:autoCompleteCellIdentifier];
    }
    cell.textLabel.text = autoCompleteResults[indexPath.row];
    cell.accessibilityLabel = [NSString stringWithFormat:@"{%ld,%ld}", (long) indexPath.section, (long) indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = [self tableView:tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self resignFirstResponder];
}

#pragma mark - UIGestureRecognizerDelegate

/**
* Check the bounds of the tap gesture to make sure it doesn't interfere with the UITableViewCell taps.
*/
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == tapGestureRecognizer && autoCompleteResults.count) {
        CGPoint location = [gestureRecognizer locationInView:self.autoCompleteTableView];
        UITableViewCell *lastCell = [self.autoCompleteTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:(autoCompleteResults.count - 1) inSection:0]];
        if (lastCell.frame.origin.y + lastCell.frame.size.height >= location.y) {
            return NO;
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

#pragma mark - AutoCompleteSearchDelegate

- (void)onAutoCompleteResultsReceived:(NSArray *)results {
    autoCompleteResults = results;
    if (results && results.count) {
        [self showAutoCompleteView];
    } else {
        [self hideAutoCompleteView];
    }
}

#pragma mark - Events

- (void)reloadData {
    [self updateAutoCompleteResults];
    [self.autoCompleteTableView reloadData];
}

- (void)updateAutoCompleteResults {
//    [self.operationQueue cancelAllOperations];

    if ([self.text isEqualToString:@""]) {
        return;
    }

    [self startFetching:self.text];
}

- (BOOL)becomeFirstResponder {
    [self reloadData];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    [self hideAutoCompleteView];
    return [super resignFirstResponder];
}

#pragma mark - Show/Hide AutoCompleteTable

- (void)showAutoCompleteView {
    if (_autoCompleteTableView) {
//        [self.autoCompleteTableView setHidden:NO];
//        [self.superview bringSubviewToFront:self];
//        [self.superview insertSubview:self.autoCompleteTableView
//                         belowSubview:self];
//        [self.autoCompleteTableView setUserInteractionEnabled:YES];
        [self.autoCompleteTableView reloadData];
        [self showPopup];
    }
}

- (void)hideAutoCompleteView {
    if (_autoCompleteTableView) {
//        [self.autoCompleteTableView setHidden:YES];
        [self.autoCompleteTableView removeFromSuperview];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutAutoCompleteTable];
    [self updateAutoCompleteResults];
}

- (void)layoutAutoCompleteTable {
    [self resetAutoCompleteTableFrame];
    // This background give a shadow effect to the views behind the table.
    [self.autoCompleteTableView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    // Remove the footer's separator.
    [self.autoCompleteTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self setInputAccessoryView:nil];
}

- (void)resetAutoCompleteTableFrame {
    [self.autoCompleteTableView setFrame:[self getAutoCompleteTableFrame]];
    // Scroll to top of Table.
    [self.autoCompleteTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

- (CGRect)getAutoCompleteTableFrame {
    CGRect frame = self.frame;
    frame.origin.y += self.frame.size.height;
    frame.size.height = self.superview.frame.size.height - self.frame.size.height;
    return frame;
}

#pragma mark UIPopoverController

- (void)showPopup {
//    self.popoverController.popoverContentSize = _autoCompleteTableView.contentSize;

    [self.popoverController presentPopoverFromBarButtonItem:self.parentItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

#pragma mark

- (void)startFetching:(NSString *)searchString {
    NSURLSessionDataTask *task =
            [[MABYT3_AutoCompleteRequest sharedInstance]
                    autoCompleteSuggestionsWithSearchWish:searchString
                                               completion:^(YoutubeResponseInfo *responseInfo, NSError *error) {
                                                   if (responseInfo) {
                                                       [self onAutoCompleteResultsReceived:responseInfo.array];
                                                   } else {
                                                       NSLog(@"ERROR: %@", error);
                                                   }
                                               }];
}


@end