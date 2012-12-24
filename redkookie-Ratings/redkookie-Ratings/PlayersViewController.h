//
//  PlayersViewController.h
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *players;

- (UIImage *)imageForRating:(int)rating;

@end
