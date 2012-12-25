//
//  MyCustomCell.h
//  redkookie-CustomCell
//
//  Created by Kim cloody on 12. 12. 24..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *articleName;
@property (strong, nonatomic) IBOutlet UILabel *authorName;
@property (strong, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *viewForBackground;

@end
