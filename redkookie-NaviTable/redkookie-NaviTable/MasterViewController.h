//
//  MasterViewController.h
//  redkookie-NaviTable
//
//  Created by Kim cloody on 12. 12. 10..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSArray *dataArray;

@end
