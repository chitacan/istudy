//
//  RatingDetailViewController.h
//  redkookie-Ratings
//
//  Created by cloody on 12. 12. 27..
//  Copyright (c) 2012년 AhnLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingDetailViewController;

@protocol RatingDetailViewControllerDelegate <NSObject>
- (void)ratingDetailViewController:(RatingDetailViewController *)controller
                   didSelectRating:(NSInteger) rating;
@end

@interface RatingDetailViewController : UITableViewController

@property (nonatomic, weak) id <RatingDetailViewControllerDelegate> delegate;
@property (nonatomic, assign) NSInteger rating;

@end
