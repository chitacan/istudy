//
//  MainViewController.h
//  importre-viewcontroller
//
//  Created by importre on 12. 12. 14..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MainViewController : UITableViewController

// examples
// 1. uitableview with nsarray
// 2. delete row from uitableview
// 3. table with property list
// 4. handle row selection
// 5. custom uitable cell
// 6. search into a tableview
@property (strong, nonatomic) NSMutableArray *examples;

@property (strong, nonatomic) DetailViewController *viewController;

@end
