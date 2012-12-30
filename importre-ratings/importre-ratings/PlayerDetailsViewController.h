//
//  PlayerDetailsViewController.h
//  importre-ratings
//
//  Created by importre on 12. 12. 30..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePickerViewController.h"

@class PlayerDetailsViewController;
@class Player;

@protocol PlayerDetailsViewControllerDelegate <NSObject>
- (void)playerDetailsViewControllerDidCancel: (PlayerDetailsViewController *)controller;
- (void)playerDetailsViewController: (PlayerDetailsViewController *)controller
                       didAddPlayer:(Player *)player;
@end

@interface PlayerDetailsViewController : UITableViewController <GamePickerViewControllerDelegate>

@property (nonatomic, weak) id <PlayerDetailsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, readwrite) NSString *game;
@property (strong, nonatomic) IBOutlet UITableViewCell *detailLabel;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
