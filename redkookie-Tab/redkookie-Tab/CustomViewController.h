//
//  CustomViewController.h
//  redkookie-Tab
//
//  Created by Kim cloody on 12. 12. 13..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil setTitle:(NSString *)title;

@end
