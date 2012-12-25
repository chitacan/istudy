//
//  PlayerCell.m
//  redkookie-Ratings
//
//  Created by Kim cloody on 12. 12. 25..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "PlayerCell.h"

@implementation PlayerCell

@synthesize nameLabel = _nameLabel;
@synthesize gameLabel = _gameLabel;
@synthesize ratingImageView = _ratingImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
