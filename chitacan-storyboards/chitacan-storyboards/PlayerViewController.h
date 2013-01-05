//
//  PlayerViewController.h
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 12. 12. 31..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDetailsViewController.h"

@interface PlayerViewController : UITableViewController<PlayerDetailsViewControllerDelegate>

@property(nonatomic, retain) NSMutableArray *players;

@end
