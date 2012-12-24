//
//  MyCustomCell.m
//  redkookie-CustomCell
//
//  Created by Kim cloody on 12. 12. 24..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import "MyCustomCell.h"

@implementation MyCustomCell

@synthesize articleName;
@synthesize authorName;
@synthesize date;
@synthesize imageView;
@synthesize viewForBackground;

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
