//
//  CandyTableViewController.h
//  redkookie-CandySearch
//
//  Created by cloody on 13. 1. 5..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong,nonatomic) NSArray *candyArray;

@property (strong,nonatomic) NSMutableArray *filteredCandyArray;
@property IBOutlet UISearchBar *candySearchBar;

-(IBAction)goToSearch:(id)sender;

@end
