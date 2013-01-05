//
//  PlayerDetailsViewController.h
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 13. 1. 2..
//  Copyright (c) 2013년 kyung yeol Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerDetailsViewController;

@protocol PlayerDetailsViewControllerDelegate <NSObject>

- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController*)controller;
- (void)playerDetailsViewControllerDidDone:(PlayerDetailsViewController*)controller;

@end

@interface PlayerDetailsViewController : UITableViewController

@property (nonatomic,weak) id<PlayerDetailsViewControllerDelegate> delegate NS_DEPRECATED_IOS(3_0,4_0);

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end
