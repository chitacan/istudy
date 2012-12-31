//
//  PlayerCell.h
//  chitacan-storyboards
//
//  Created by kyung yeol Kim on 12. 12. 31..
//  Copyright (c) 2012년 kyung yeol Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *gameLable;
@property (nonatomic, strong) IBOutlet UIImageView *ratingImageView;

@end
