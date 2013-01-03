//
//  ScrollViewContainer.h
//  redkookie-ScrollViews
//
//  Created by cloody on 13. 1. 3..
//  Copyright (c) 2013년 cloody. All rights reserved.
//
// 이 클래스가 생겨난 이유 :
// 스토리보드의 스크롤뷰에서 Clip Subview 옵션을 제거했기 때문에..
// 스크롤 뷰의 싸이즈를 벗어나서 그려지는 부분을 지우지 않게 됨 ( 그래야 다음, 이전 사진이 살짝 보임 )
// 하지만 스크롤뷰는 자신의 영역을 터치했을 때에만 스크롤이 동작함,
// 위에 살짝 보여진 다음, 이전 영역은 터치해도 스크롤이 동작하지 않음.
// 그 문제를 해결하기 위해 필요함. 
//

#import <UIKit/UIKit.h>

@interface ScrollViewContainer : UIView

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
