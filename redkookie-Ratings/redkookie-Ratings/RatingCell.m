//
//  RatingCell.m
//  redkookie-Ratings
//
//  Created by cloody on 12. 12. 27..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import "RatingCell.h"

@implementation RatingCell

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
