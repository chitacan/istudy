//
//  PagedScrollViewController.h
//  redkookie-ScrollViews
//
//  Created by cloody on 13. 1. 3..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedScrollViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@end
