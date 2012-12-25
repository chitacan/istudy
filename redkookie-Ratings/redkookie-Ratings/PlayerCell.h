//
//  PlayerCell.h
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *gameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *ratingImageView;

@end
