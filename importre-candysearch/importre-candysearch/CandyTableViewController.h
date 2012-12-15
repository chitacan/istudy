//
//  CandyTableViewController.h
//  importre-candysearch
//
//  Created by importre on 12. 12. 15..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandyTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *candyArray;
@property (strong, nonatomic) NSMutableArray *filteredCandyArray;
@property (strong, nonatomic) IBOutlet UISearchBar *candySearchBar;

@end
