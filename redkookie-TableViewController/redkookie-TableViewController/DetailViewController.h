//
//  DetailViewController.h
//  redkookie-TableViewController
//
//  Created by Kim cloody on 12. 12. 13..
//  Copyright (c) 2012 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
