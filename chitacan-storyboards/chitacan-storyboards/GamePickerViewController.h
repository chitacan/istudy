//
//  GamePickerViewController.h
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 13. 1. 7..
//  Copyright (c) 2013년 kyung yeol Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamePickerViewController;

@protocol GamePickerViewControllerDelegate <NSObject>

- (void)gamePickerViewController:(GamePickerViewController*)controller didSelectGame:(NSString*)game;

@end

@interface GamePickerViewController : UITableViewController

@property (nonatomic, weak) id<GamePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString* game;

@end
