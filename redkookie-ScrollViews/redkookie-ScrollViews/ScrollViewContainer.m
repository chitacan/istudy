//
//  ScrollViewContainer.m
//  redkookie-ScrollViews
//
//  Created by cloody on 13. 1. 3..
//  Copyright (c) 2013년 cloody. All rights reserved.
//

#import "ScrollViewContainer.h"

@implementation ScrollViewContainer

@synthesize scrollView = _scrollView;

// 아놔.. 이 메소드에 대한 설명을 안써 놓네..
// 뷰가 서로 겹쳐서 아래에 있는 뷰가 터치 이벤트를 받지 못할때 위에 있는 뷰의 hitTest라는 메소드를 오버라이딩한다.
// 이 함수는 주어진 point와 event가 현재 View에서 동작하는가를 체크해 주는 것이다.

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    NSLog(@"Hit");
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self)
    {
        // hit 된 곳이 자기 자신이면 스크롤을 할 수 있도록 스크롤 뷰를 리턴
        return _scrollView;
    }
    // 자기 자신이 아니면, 그 hit 된 뷰를 리턴 
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
