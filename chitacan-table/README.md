# UITableViewController

## 기본적인 정보들

* `UITableViewController` 의 헤더를 보면 다음과 같이 선언되어 있다. 
	```
UITableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
	```
	* 즉 `UITableViewController` 는 `UITableViewDelegate`, `UITableViewDataSource` 프로토콜을 따르고 있다. 하지만 내가 만든 `ViewController`는 `UITableViewDelegate` 프로토콜은 구현하지 않았는데??
		* 일단 `UITableViewDelegate` 의 경우, 메소드가 모두 `@optional` 임
		* 내가 구현한 `ViewController`이 `conformsToProtocol` 메소드에 반응하는 것으로 보아, 일단 두 프로토콜을 따르는 것은 확실함
		```
if ([self conformsToProtocol:@protocol(UITableViewDataSource)]) {
	NSLog(@"this viewcontroller conforms to protocol UITableViewDataSource");
}
		```
		* 메소드 `numberOfSectionsInTableView` 의 경우 내가 구현한 `ViewController`에 구현 내용이 없음에도 불구하고 메소드가 처리되는 것으로 보아 `UITableViewController` 에 이미 구현이 되어 있는 듯 싶다.

## import의 ""과 <>의 차이는??

* "" 의 경우 컴파일러는 같은 디렉토리의 헤더를 찾는다.
	* 같은 프로젝트의 헤더일 경우 ""를 사용하면 됨
* <> 의 경우 다른 디렉토리의 헤더를 찾는다.
	* 프레임워크의 헤더를 가져올 경우 사용한다.

## introspection vs reflection

* obj-c를 보다보면 introspection과 관련된 메소드들을 찾을 수 있다.
	* `respondsToSelector` 또는 `isKindOfClass` 등등
* 이는 사실 자바에서 자주 사용하는 `reflection` 이란 개념과 매우 헷갈리는데 (런타임에 해당 객체를 검사) 정확하게 살펴보면 다음과 같다.

| introspection | reflection    |
| ------------- | ------------- |
| 런타임에 특정 객체를 검사  | 런타임에 특정 객체 검사 & 변경  |

* 즉 reflection은 런타임에 특정 객체의 메소드를 실행하거나 값을 변경할 수도 있는 개념을 말한다.
	* 실제로 자바의 reflection 을 사용하면 런타임에 객체의 값을 변경할 수 있다.
	* 하지만 obj-c에서는 introspection의 개념까지 사용가능하다.

## xib 파일은 다른 소스파일과 어떻게 연결되는가??

## tableView:commitEditingStyle:forRowAtIndexPath 의 동작방식

* `UITableViewDataSource` 프로토콜에 `@optional`로 선언되어 있는 메소드
* [delete row from uitableview](http://www.appcoda.com/model-view-controller-delete-table-row-from-uitableview/) 에서는 사용자가 swipe 할때 해당 메소드의 구현여부를 따져서 버튼 표시여부를 결정한다고 설명하고 있다.
* 하지만 아래의 코드와 같이 해당 클래스의 `respondsToSelector` 메소드를 오버라이드해 디버깅 해 본 결과
```
- (BOOL) respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(tableView:commitEditingStyle:forRowAtIndexPath:)) {
        NSLog(@"%@", [NSThread callStackSymbols]);
        return true;
    }
    else
        return [super respondsToSelector:aSelector];
}
```
* 사용자가 swipe 동작을 할 때가 아니라 `UITableView`에 `UITableViewDataSource` 프로토콜의 구현체가 세팅될때 해당 메소드의 구현여부를 살펴 `delete` 버튼의 표출여부를 결정한다.

## 스택트레이스 출력하기

* 특정 메소드를 호출하기까지 호출된 메소드를 살펴볼 수 있는 스택트레이스는 다음의 코드로 확인할 수 있다.
	```
NSLog(@"%@",[NSThread callStackSymbols]);
	```

* 다음은 `(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;` 메소드의 스택트레이스 이다.
	```
2012-12-23 22:49:10.011 chitacan-table[3333:c07] (
	0   chitacan-table                      0x00002a91 -[ViewController tableView:cellForRowAtIndexPath:] + 609
	1   UIKit                               0x000cdf4b -[UITableView(UITableViewInternal) _createPreparedCellForGlobalRow:withIndexPath:] + 412
	2   UIKit                               0x000ce01f -[UITableView(UITableViewInternal) _createPreparedCellForGlobalRow:] + 69
	3   UIKit                               0x000b680b -[UITableView(_UITableViewPrivate) _updateVisibleCellsNow:] + 1863
	4   UIKit                               0x000c719b -[UITableView layoutSubviews] + 241
	5   UIKit                               0x0006392d -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 279
	6   libobjc.A.dylib                     0x010df6b0 -[NSObject performSelector:withObject:] + 70
	7   QuartzCore                          0x0228afc0 -[CALayer layoutSublayers] + 240
	8   QuartzCore                          0x0227f33c _ZN2CA5Layer16layout_if_neededEPNS_11TransactionE + 468
	9   QuartzCore                          0x0228aeaf -[CALayer layoutIfNeeded] + 166
	10  UIKit                               0x001028cd -[UIViewController window:setupWithInterfaceOrientation:] + 242
	11  UIKit                               0x0004b1a6 -[UIWindow _setRotatableClient:toOrientation:updateStatusBar:duration:force:isRotating:] + 5346
	12  UIKit                               0x00049cbf -[UIWindow _setRotatableClient:toOrientation:updateStatusBar:duration:force:] + 82
	13  UIKit                               0x00049bd9 -[UIWindow _setRotatableViewOrientation:duration:force:] + 89
	14  UIKit                               0x00048e34 __57-[UIWindow _updateToInterfaceOrientation:duration:force:]_block_invoke_0 + 224
	15  UIKit                               0x00048c6e -[UIWindow _updateToInterfaceOrientation:duration:force:] + 209
	16  UIKit                               0x00049a29 -[UIWindow setAutorotates:forceUpdateInterfaceOrientation:] + 853
	17  UIKit                               0x0004c922 -[UIWindow setDelegate:] + 351
	18  UIKit                               0x000f6fec -[UIViewController _tryBecomeRootViewControllerInWindow:] + 164
	19  UIKit                               0x00043bc4 -[UIWindow addRootViewControllerViewIfPossible] + 481
	20  UIKit                               0x00043dbf -[UIWindow _setHidden:forced:] + 368
	21  UIKit                               0x00043f55 -[UIWindow _orderFrontWithoutMakingKey] + 49
	22  UIKit                               0x0d933d84 -[UIWindowAccessibility(SafeCategory) _orderFrontWithoutMakingKey] + 77
	23  UIKit                               0x0004cf67 -[UIWindow makeKeyAndVisible] + 65
	24  chitacan-table                      0x000023c0 -[AppDelegate application:didFinishLaunchingWithOptions:] + 1200
	25  UIKit                               0x000107b7 -[UIApplication _handleDelegateCallbacksWithOptions:isSuspended:restoreState:] + 266
	26  UIKit                               0x00010da7 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1248
	27  UIKit                               0x00011fab -[UIApplication _runWithURL:payload:launchOrientation:statusBarStyle:statusBarHidden:] + 805
	28  UIKit                               0x00023315 -[UIApplication handleEvent:withNewEvent:] + 1022
	29  UIKit                               0x0002424b -[UIApplication sendEvent:] + 85
	30  UIKit                               0x00015cf8 _UIApplicationHandleEvent + 9874
	31  GraphicsServices                    0x01be9df9 _PurpleEventCallback + 339
	32  GraphicsServices                    0x01be9ad0 PurpleEventCallback + 46
	33  CoreFoundation                      0x01c03bf5 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__ + 53
	34  CoreFoundation                      0x01c03962 __CFRunLoopDoSource1 + 146
	35  CoreFoundation                      0x01c34bb6 __CFRunLoopRun + 2118
	36  CoreFoundation                      0x01c33f44 CFRunLoopRunSpecific + 276
	37  CoreFoundation                      0x01c33e1b CFRunLoopRunInMode + 123
	38  UIKit                               0x000117da -[UIApplication _run] + 774
	39  UIKit                               0x0001365c UIApplicationMain + 1211
	40  chitacan-table                      0x00001edd main + 141
	41  chitacan-table                      0x00001e05 start + 53
)
	```
	* 보면 몇가지 흥미로운 점을 발견할 수 있는데 위 메소드가 처음 호출되는 시점은 `[UIWindow makeKeyAndVisible]` 이라는 것.
	* 중간에 `QuartzCore`를 통해 실제 레이아웃이 그려진다는 점.

## Open Quickly

`cmd + shift + o` 단축키로 프로젝트의 클래스 뿐만 아니라, 프레임워크의 헤더도 빠르게 열어볼 수 있다.