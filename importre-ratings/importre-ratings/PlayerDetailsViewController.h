//
//  PlayerDetailsViewController.h
//  importre-ratings
//
//  Created by importre on 12. 12. 30..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerDetailsViewController;

@protocol PlayerDetailsViewControllerDelegate <NSObject>
- (void)playerDetailsViewControllerDidCancel: (PlayerDetailsViewController *)controller;
- (void)playerDetailsViewControllerDidSave: (PlayerDetailsViewController *)controller;
@end

@interface PlayerDetailsViewController : UITableViewController <PlayerDetailsViewControllerDelegate>

@property (nonatomic, weak) id <PlayerDetailsViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
