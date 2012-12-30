//
//  PlayersViewController.h
//  importre-ratings
//
//  Created by importre on 12. 12. 30..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"

@interface PlayersViewController : UITableViewController <PlayerDetailsViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *players;

@end
