//
//  AutoCompleteSearchBar.h
//
//  Created by Matthew Ott on 2/27/15.
//

#import <UIKit/UIKit.h>

@interface AutoCompleteSearchBar : UISearchBar <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate> {
    NSArray *autoCompleteResults;
    UIGestureRecognizer *tapGestureRecognizer;
}

@property(nonatomic, retain) UIPopoverController *popoverController;
@property(strong, readwrite) UITableView *autoCompleteTableView;
@property(strong, readwrite) UIBarButtonItem *parentItem;

- (void)reloadData;

- (void)hideAutoCompleteView;
@end
