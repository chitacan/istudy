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

