//
//  AutoCompleteSearchBar.h
//
//  Created by Matthew Ott on 2/27/15.
//

#import <UIKit/UIKit.h>

@interface AutoCompleteSearchBar : UISearchBar <UIGestureRecognizerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray *autoCompleteResults;
    UIGestureRecognizer *tapGestureRecognizer;
}

@property(nonatomic, retain) UIPopoverController *popoverController;
@property(strong, readwrite) UITableView *autoCompleteTableView;

- (void)reloadData;

- (void)hideAutoCompleteView;
@end
