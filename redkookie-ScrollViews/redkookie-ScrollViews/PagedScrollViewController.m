//
//  PagedScrollViewController.m
//  redkookie-ScrollViews
//
//  Created by cloody on 13. 1. 3..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import "PagedScrollViewController.h"

@interface PagedScrollViewController ()

// This will hold all the images to display – 1 per page.
@property (nonatomic, strong) NSArray *pageImages;
// This will hold instances of UIImageView to display each image on its respective page. It’s a mutable array, because you’ll be loading the pages lazily
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation PagedScrollViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

@synthesize pageImages = _pageImages;
@synthesize pageViews = _pageViews;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count)
    {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // 1
    UIView *pageView = [self.pageViews objectAtIndex:page];
    // 널이라면 페이지 로딩이 필요함 
    if ((NSNull*)pageView == [NSNull null])
    {
        // 2
        CGRect frame = self.scrollView.bounds;
        // x 는 페이지 번호만큼 옆으로 가서 위치
        frame.origin.x = frame.size.width * page;
        // y 는 0 부터 
        frame.origin.y = 0.0f;
        
        // 3
        // 새로운 페이지를 만들고
        // 위에서 정의한 프레임에다가
        // 스크롤뷰에 넣기
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.pageImages objectAtIndex:page]];
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
        [self.scrollView addSubview:newPageView];
        
        // 4
        // 어레이에 널 대신에 생성한 이미지뷰 넣기 
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageImages.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    // 널이 아니라면 페이지가 로딩되어 있는 상태
    if ((NSNull*)pageView != [NSNull null])
    {
        // 페이제에게 너의 부모 뷰로부터 나가라
        [pageView removeFromSuperview];
        // 어레이에는 널을 다시 넣어놈 
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

// 페이지를 잡고 스크롤 하는 동안은 (뷰가 그려지거나 변경되어 그려지는 동안은) 계속 호출된다. 
- (void)loadVisiblePages {
    // First, determine which page is currently visible
    // 현재 사용자가 보고 있는 페이지를 계산함, 여기는 너가 원하는 대로 만들어도 됨.
    // 넓이는 스크롤 뷰의 프레임 넓이 (320)
    CGFloat pageWidth = self.scrollView.frame.size.width;
    // contentOffset.x 는 현재 스크롤뷰의 x 위치
    // * 2.0f -> 페이지의 절반 이상 넘어가게 되면 페이지의 변경이 진행된다.
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    NSLog([NSString stringWithFormat:@"width : %f, offset : %f", pageWidth, self.scrollView.contentOffset.x]);
    
    // Update the page control
    // 사용자에게 보여줘야할 페이지 번호 셋팅 
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    // 현재 페이지의 앞과 뒤인 번호를 생성 
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    // 0 부터 페이지의 앞앞 까지는 퍼지해버림
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
	// Load pages in our range
    // 현 페이지의 앞과 뒤는 이미지롤 로딩해 놓음
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
	// Purge anything after the last page
    // 현 페이지의 뒤뒤 부터 끝까지는 퍼지해버림 
    for (NSInteger i=lastPage+1; i<self.pageImages.count; i++) {
        [self purgePage:i];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 1
    self.pageImages = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"photo1.png"],
                       [UIImage imageNamed:@"photo2.png"],
                       [UIImage imageNamed:@"photo3.png"],
                       [UIImage imageNamed:@"photo4.png"],
                       [UIImage imageNamed:@"photo5.png"],
                       nil];
    
    NSInteger pageCount = self.pageImages.count;
    
    // 2
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = pageCount;
    
    // 3
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i)
    {
        // [NSNull null] : it’s a lightweight singleton object that can be added to an array to signify a placeholder
        [self.pageViews addObject:[NSNull null]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 4
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageImages.count, pagesScrollViewSize.height);
    
    // 5
    [self loadVisiblePages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
