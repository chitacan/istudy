# view controller

xcode 4.5.2 기준 `single view application` 템플릿을 바탕으로 진행.

## 참고자료

[Programmatically Create NavigationController](http://www.youtube.com/watch?v=pDNrFL1t9js)

## UIViewController

* [Class Reference 참고](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UIViewController_Class/Reference/Reference.html)
* 뷰들을 관리하는 단위.
* 주요 서브 클래스로는 `UINavigationController`, `UITabBarController`, `UITableViewController` 등이 있다.

## 앱의 시작점

* 모든 ios 앱의 시작점은 `main.m` 파일.
* `main.m`의 메인은 UIApplication의 클래스 메소드 `UIApplicationMain` 하나만 호출하도록 되어있다.
	* 내부적으로 앱을 위한 이밴트 루프를 생성하며, 리턴 값은 있지만 리턴이 되지 않음
	* 4번째 인자로 해당 앱의 `AppDelegate` 클래스 이름을 받으며, `UIApplicationDelegate` 프로토콜을 통해 해당 클래스에게` application:didFinishLaunchingWithOptions:` 메시지를 전달해 준다.
	* 즉 실질적인 앱의 시작점은 AppDelegate 클래스의 `application:didFinishLaunchingWithOptions:` 이다.

* `application:didFinishLaunchingWithOptions:` 메소드의 역할은 아래와 같다.
	* 윈도우 객체 초기화
	* `ViewController.xib` 파일을 통해 viewcontroller 초기화
	* 윈도우와 viewcontroller 연결

## AppDelegate 클래스

* `UIResponder`를 상속받도록 기본 템플릿에 설정되어 있다.
	* `UIResponder`를 통해 기본 터치 이벤트, 모션 이벤트등 오버라이드 할 수 있음.

## UINavigationController

UINavigationController는 계층적인 구조의 컨텐츠를 보여주기에 적합한 뷰 컨트롤러.

* [Class Reference 참고](https://developer.apple.com/library/ios/#documentation/UIKit/Reference/UINavigationController_Class/Reference/Reference.html)

## UITabBarController.h에 선언된 UIViewController 인터페이스???

UITabBarController.h 를 살펴보면 아래와 같은 UIViewController 관련 인터페이스가 선언되어 있는 것을 확인할 수 있다.

```
@interface UIViewController (UITabBarControllerItem)

@property(nonatomic,retain) UITabBarItem *tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

@property(nonatomic,readonly,retain) UITabBarController *tabBarController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end
```

UITabBarController 의 헤더에 왜 뜬금없이 UIViewController와 관련된 인터페이스가 선언되어 있을까??

### 카테고리

위와 같이 `@interface UIViewController (UITabBarControllerItem)` 와 같이 선언된 인터페이스를 obj-C에서는 `카테고리` 라고 부른다.

* 카테고리를 사용하면 이미 존재하는 클래스(NSString, NSObject 등)에 **새로운 메소드** 를 추가할 수 있다.
* 카테고리는 마치 기존 스크립트 언어들에서 특정 클래스에 메소드나 프로퍼티를 추가하는 형태랑 비슷한데, 한가지 다른점이 있다면 **메소드** 만 추가할 수 있다는 점이다.
* 카테고리는 다음과 같은 목적으로 사용할 수 있다.
	* 소스가 없는 (헤더만 가진) 클래스를 확장하고자 할때
	* 클래스의 구현을 여러클래스(카테고리에 따라) 걸쳐 구현하고자 할때
	* 서브 클래싱의 또다른 방법중 하나
	* 카테고리를 통해 기존에 존재하는 메소드 이름을 추가할 경우, 해당 메소드를 완전히 대체할 수 있다. 오버라이딩과 비슷한 개념이나, 오버라이드된 메소드를 호출할 방법이 없다는 것이 차이점(추가조사 필요)
* 카테고리는 아래와 같이 선언할 수 있다.
	```
@interface ORIGINAL_CLASS_NAME (CATEGORY_NAME)
@end
	```
* 즉 UITabBarController.h 에 선언된 카테고리는 이름이 `UITabBarControllerItem` 이며, `UIViewController`에 메소드를 추가하려는 것임을 알 수 있다.

### property in category??

그런데 신기하게도 `UITabBarControllerItem` 카테고리는 메소드가 아닌 프로퍼티를 `UIViewController` 에 추가했다. 안된다며???

* UITabBarController.m 파일을 확인할 수는 없지만 옆에 딸린 코멘트를 보면 `tabBarItem` 메소드는 내부적으로 `UIViewController`의 title 프로퍼티를 사용하는 것으로 보인다.

만약, 정말로 @property를 통해 프로퍼티를 선언하고 내부적으로 어떤 값을 저장하고자 한다면 어떻게 할까?

* [Adding Properties to an Objective-C Category](http://www.davidhamrick.com/2012/02/12/Adding-Properties-to-an-Objective-C-Category.html) 참고
* [objc_setAssociatedObject](https://developer.apple.com/library/ios/#documentation/Cocoa/Reference/ObjCRuntimeRef/Reference/reference.html) 를 통해 해당 클래스와 관련된 프로퍼티의 레퍼런스를 저장할 수 있다.

