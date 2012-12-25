//
//  PlayerDetailsViewController.h
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "GamePickerViewController.h"

@class PlayerDetailsViewController;

// 프로토콜로 델리게이트 메소드 2개 선언 
// use to communicate back from the Add Player screen to the main Players screen when the user taps Cancel or Done.
@protocol PlayerDetailsViewControllerDelegate <NSObject>
- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller 
                       didAddPlayer:(Player *)player;
@end

@interface PlayerDetailsViewController : UITableViewController <GamePickerViewControllerDelegate>

// 프로퍼티로 위에 선언한 델리게이트 객체 선언 , weak ???
@property (nonatomic, weak) id <PlayerDetailsViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

// 켄슬과 돈 에 대한 메소드 선언 
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
