//
//  PlayerDetailsViewController.h
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 13. 1. 2..
//  Copyright (c) 2013년 kyung yeol Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePickerViewController.h"

@class Player;
@class PlayerDetailsViewController;

@protocol PlayerDetailsViewControllerDelegate <NSObject>

- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController*)controller;
- (void)playerDetailsViewController:(PlayerDetailsViewController*)controller didAddPlayer:(Player*)player;

@end

@interface PlayerDetailsViewController : UITableViewController <GamePickerViewControllerDelegate>

@property (nonatomic,weak) id<PlayerDetailsViewControllerDelegate> delegate NS_DEPRECATED_IOS(3_0,4_0);

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

-(IBAction)cancel:(id)sender;
-(IBAction)done:(id)sender;

@end
