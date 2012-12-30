//
//  GamePickerViewController.h
//  importre-ratings
//
//  Created by importre on 12. 12. 30..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamePickerViewController;

@protocol GamePickerViewControllerDelegate <NSObject>
- (void)gamePickerViewController:(GamePickerViewController *)controller
                   didSelectGame:(NSString *)game;
@end

@interface GamePickerViewController : UITableViewController

@property (nonatomic, strong) NSArray *games;
@property (nonatomic, readwrite) NSUInteger selectedIndex;

@property (nonatomic, weak) id<GamePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *game;

@end
