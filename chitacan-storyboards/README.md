**Table of Contents**  *generated with [DocToc](http://doctoc.herokuapp.com/)*

- [Stroyboards](#stroyboards)
	- [Instance Variables in the Implemetation file](#instance-variables-in-the-implemetation-file)
	- [@ symbol at objective-c](#@-symbol-at-objective-c)
		- [NSNumber](#nsnumber)
		- [Array](#array)
		- [Dictionary](#dictionary)
		- [class](#class)
	- [lldb 디버거](#lldb-디버거)
		- [LLDB View Hierarchy Dump](#lldb-view-hierarchy-dump)
	- [Auto resizing과 Constraints](#auto-resizing과-constraints)
	- [SEL은 어디에 선언되어 있는가??](#sel은-어디에-선언되어-있는가??)
	- [delegate 패턴](#delegate-패턴)
	- [send message to nil](#send-message-to-nil)
	- [NS_AVAILABLE_IOS 매크로](#ns_available_ios-매크로)
	- [define NS_DEPRECATED_IOS(_iosIntro, _iosDep) 매크로](#define-ns_deprecated_ios_iosintro-_iosdep-매크로)
	- [iOS 는 2.0 부터 있다??](#ios-는-20-부터-있다??)
	- [Derived Data](#derived-data)
	- [Segue](#segue)
	- [what is "First Responder" ??](#what-is-"first-responder"-??)
	- [emoji](#emoji)
	- [](#)

# Stroyboards

## Instance Variables in the Implemetation file

이번 tuts를 진행하다보니 아래와 같이 instance variable을 선언해보라는 내용이 있었다.

```
@implementation AppDelegate {
	NSMutableArray *players;
}
```

* 컴파일 에러가 떨어지지 않아서 이래도 되나 했는데, 정확하게 왜, 어느 경우에 사용할 수 있는지를 몰라 검색해 보았음
* [이곳](http://mobiledevelopertips.com/objective-c/instance-variables-in-implementation-file.html)의 내용을 정리해 보면
	* instance variable을 implementation file에 선언할 수 있는건 LLVM 컴파일러 때문 (오!! :smirk:)
	* 이를 활용하면 public 으로 사용할 변수 interface 에 공개할 수 있어 유용하다.

## @ symbol at objective-c

objective-c에서 @ 심볼은 해당 문구는 c, c++에 속하지 않는, objective-c에서만 사용된다는 것을 의미한다.
기존에 NSString 클래스를 @"" 으로 바로 생성할 수 있었는데, 최근에 몇가지가 더 추가되었다.(이를 objective-c literals 라고 한다.)

* 참고링크 : [Objective-C Literals](http://clang.llvm.org/docs/ObjectiveCLiterals.html), [Objective-C Literals, Part 1](http://blog.bignerdranch.com/398-objective-c-literals-part-1/), [@](http://www.nshipster.com/at-compiler-directives/)
* `(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath` 메소드에 자동으로 생성된 템플릿에 "@[indexPath]" 가 사용되어 파보게 되었음

### NSNumber

숫자 앞에 @ 심볼을 붙여서 `NSNumber` 클래스의 인스턴스로 바로 생성할 수 있다.

```
NSNumber *fortyTwo = @42;             // equivalent to [NSNumber numberWithInt:42]
NSNumber *fortyTwoUnsigned = @42U;    // equivalent to [NSNumber numberWithUnsignedInt:42U]
```

### Array

square bracket("[") 앞에 @ 심볼을 붙여 `NSArray` 의 인스턴스를 바로 생성할 수 있다.

```
NSArray *gronk = @[ @"hi", @"bork", @23, @YES ];
```

### Dictionary

brace("{") 앞에 @ 심볼을 붙여 `NSDictionary`의 인스턴스를 바로 생성할 수 있다.

```
NSDictionary *splunge = @{ @"hi" :  @"bork", @"greeble" :  @"bork" };
```

### class

@class 는 어떤 상황에 사용해야 하나??

* 전방참조에 사용됨
	* 헤더 파일을 직접 import 하지 않고, 해당 클래스가 있다라는 것만 선언해 주는 것. 
	* 해당 클래스를 포인터로 사용할 때만 가능하다. (보통 포인터는 4바이트 이므로)


## lldb 디버거

llvm 프로젝트를 활용해 만들어진 디버거로 최신 xcode의 디폴트 디버거이다.

* 최신 xcode에서 코드에 break point 를 설정하고 앱을 실행하면 output 화면에 `(lldb)` 라는 프롬프트를 확인할 수 있다.
* 여기에 GDB 스타일로 커맨드를 통해 디버깅을 진행할 수 있다. 아래는 간단한 몇가지 명령어.

	| 커맨드 | 설명 |
	| ------------- | ------------- |
	| step(또는 s)  | step in  |
	| next(또는 n)  | step over |
	| frame variable(또는 fr v)  | 현재 스택 프레임(함수내 지역변수, 전달받은 인자) 값 출력 |
	| bt  | stack backtrace |

	나머지 명령어들에 대한 설명은 [LLDB Tutorial](http://lldb.llvm.org/tutorial.html) 참고.

### LLDB View Hierarchy Dump

안드로이드에서는 단말의 윈도우부터 시작해서 실행중인 앱들의 뷰 계층구조를 출력할 수 있는 hierarchy viewer가 있어 런타임에 UI 디버깅을 할 수 있다. xcode엔 해당 기능이 없지만 lldb를 활용해 특정 view controller의 뷰 계층구조를 파악할 수 있다.

* `~/.lldbinit` 파일에 아래의 내용을 추가한다. (없으면 생성)
```
command regex rd 's/^[[:space:]]*$/po [[UIApp keyWindow] recursiveDescription]/' 's/^(.+)$/po [%1 recursiveDescription]/'
```
* 디버깅 하고자 하는 view controller에 break point를 걸고 lldb 프롬프트에 `rd self.view` 를 입력하면 아래와 같이 view hierarchy를 확인할 수 있다.

```
(lldb) rd self.view
po [self.view recursiveDescription]
(id) $1 = 0x088122b0 <UITableView: 0x8126e00; frame = (0 0; 320 367); clipsToBounds = YES; opaque = NO; autoresize = W+H; gestureRecognizers = <NSArray: 0x747f220>; layer = <CALayer: 0x747ebb0>; contentOffset: {0, 0}>
	| <PlayerCell: 0x7486540; baseClass = UITableViewCell; frame = (0 110; 320 55); autoresize = W; layer = <CALayer: 0x7486450>>
	|    | <UITableViewCellContentView: 0x7486480; frame = (0 0; 300 54); gestureRecognizers = <NSArray: 0x7486f50>; layer = <CALayer: 0x74864e0>>
	|    |    | <UILabel: 0x7486680; frame = (20 4; 185 23); text = 'Dave Brubeck'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 100; layer = <CALayer: 0x7486510>>
	|    |    | <UILabel: 0x7486940; frame = (20 25; 185 21); text = 'Texas Hold'em Poker'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 101; layer = <CALayer: 0x74869d0>>
	|    |    | <UIImageView: 0x7486af0; frame = (213 13; 81 27); opaque = NO; autoresize = LM+W+RM+BM; userInteractionEnabled = NO; tag = 102; layer = <CALayer: 0x7486bb0>> - 2StarsSmall.png
	|    | <UIButton: 0x7486c70; frame = (290 0; 30 54); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7486d30>>
	|    |    | <UIImageView: 0x7483500; frame = (10 20; 10 13); clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7483560>> - (null)
	|    | <UIView: 0x74855b0; frame = (0 54; 320 1); autoresize = W+TM; layer = <CALayer: 0x7485610>>
	| <PlayerCell: 0x7484680; baseClass = UITableViewCell; frame = (0 55; 320 55); autoresize = W; layer = <CALayer: 0x74847d0>>
	|    | <UITableViewCellContentView: 0x7484800; frame = (0 0; 245 54); gestureRecognizers = <NSArray: 0x74854a0>; layer = <CALayer: 0x7484860>>
	|    |    | <UILabel: 0x7484890; frame = (20 4; 185 23); text = 'Oscar Peterson'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 100; layer = <CALayer: 0x7484920>>
	|    |    | <UILabel: 0x7484cb0; frame = (20 25; 185 21); text = 'Spin the Bottle'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 101; layer = <CALayer: 0x7484d40>>
	|    |    | <UIImageView: 0x7484e60; frame = (173 13; 66 27); opaque = NO; autoresize = LM+W+RM+BM; userInteractionEnabled = NO; tag = 102; layer = <CALayer: 0x7485050>> - 5StarsSmall.png
	|    | <UIView: 0x747a0d0; frame = (0 54; 320 1); autoresize = W+TM; layer = <CALayer: 0x74834d0>>
	|    | <UIButton: 0x7485110; frame = (290 0; 30 54); alpha = 0; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x74851d0>>
	|    |    | <UIImageView: 0x74836c0; frame = (10 20; 10 13); clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7485860>> - (null)
	|    | <UITableViewCellDeleteConfirmationControl: 0x7609a80; frame = (245 0; 75 55); opaque = NO; layer = <CALayer: 0x7609e70>>
	|    |    | <_UITableViewCellDeleteConfirmationControl: 0x7609ff0; frame = (6 10; 63 34); clipsToBounds = YES; opaque = NO; tag = 3; layer = <CALayer: 0x760a0b0>>
	| <PlayerCell: 0x7482810; baseClass = UITableViewCell; frame = (0 0; 320 55); autoresize = W; layer = <CALayer: 0x7482070>>
	|    | <UITableViewCellContentView: 0x7482950; frame = (0 0; 300 54); gestureRecognizers = <NSArray: 0x7483280>; layer = <CALayer: 0x74829b0>>
	|    |    | <UILabel: 0x74829e0; frame = (20 4; 185 23); text = 'Bill Evans'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 100; layer = <CALayer: 0x7482a70>>
	|    |    | <UILabel: 0x7482aa0; frame = (20 25; 185 21); text = 'Tic-Tac-Toe'; clipsToBounds = YES; opaque = NO; autoresize = TM+BM; userInteractionEnabled = NO; tag = 101; layer = <CALayer: 0x74821b0>>
	|    |    | <UIImageView: 0x7482e30; frame = (213 13; 81 27); opaque = NO; autoresize = LM+W+RM+BM; userInteractionEnabled = NO; tag = 102; layer = <CALayer: 0x7482bc0>> - 4StarsSmall.png
	|    | <UIButton: 0x7482ef0; frame = (290 0; 30 54); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7482fb0>>
	|    |    | <UIImageView: 0x74874a0; frame = (10 20; 10 13); clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x7487660>> - (null)
	|    | <UIView: 0x7483650; frame = (0 54; 320 1); autoresize = W+TM; layer = <CALayer: 0x7484a40>>
	| <UIImageView: 0x747faa0; frame = (0 360; 320 7); alpha = 0; opaque = NO; autoresize = TM; userInteractionEnabled = NO; layer = <CALayer: 0x747fb40>> - (null)
	| <_UITableViewSeparatorView: 0x74815a0; frame = (0 219; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481630>>
	| <_UITableViewSeparatorView: 0x74818e0; frame = (0 274; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481940>>
	| <_UITableViewSeparatorView: 0x7481970; frame = (0 329; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x74819d0>>
	| <_UITableViewSeparatorView: 0x7481a00; frame = (0 384; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481a60>>
	| <_UITableViewSeparatorView: 0x7481a90; frame = (0 439; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481af0>>
	| <_UITableViewSeparatorView: 0x7481b40; frame = (0 494; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481ba0>>
	| <_UITableViewSeparatorView: 0x7481bd0; frame = (0 549; 320 1); opaque = NO; autoresize = W; layer = <CALayer: 0x7481c30>>
	| <UIImageView: 0x747fc00; frame = (313 448; 7 7); alpha = 0; opaque = NO; autoresize = LM; userInteractionEnabled = NO; layer = <CALayer: 0x747fca0>> - (null)
```

[NSHipster](http://www.nshipster.com/reader-submissions-new-years-2013/)에 다른 유용한 팁들이 더 있다!!

## Auto resizing과 Constraints

tutorial part 1 마지막에 auto resizing mask를 통해 UIImageView의 사이즈를 결정하는 화면이 나온다.

* 그런데 xcode 4.5 엔 디폴트로 size inspector에 `constraints` 들이 나와있다.
* 기존에 사용되던 auto resizing mask를 사용하기 위해서는 file inspector에 `auto layout` 옵션을 해제한다. 그리고 tutorial의 설명대로 해보자.
* auto layout에 관한 설명은 [여기](http://developer.apple.com/library/ios/#recipes/xcode_help-interface_builder/articles/UnderstandingAutolayout.html) 참고

`constraints` 는 ios6 부터 적용된 auto layout을 위한 것이다. auto layout은 기존의 auto resizing mask의 한계를 극복하기 위한 것인데, 자세한 것은 [여기](http://www.raywenderlich.com/ko/21139/ios-6%EC%97%90%EC%84%9C-%EC%98%A4%ED%86%A0-%EB%A0%88%EC%9D%B4%EC%95%84%EC%9B%83-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-%ED%8C%8C%ED%8A%B8-1-1) 참고. (무려 한글!! :smile:)

그런데 auto layout으로 tutorial의 효과 (delete 버튼이 나올때 ratingImageView의 위치 조절)을 할 수 없나? 최신 기술인데?

* 몇가지 `constraints` 조합을 사용해 보았지만 무슨 이유에서인지 잘 되지 않는다.([비슷한 시도를 한 사람이 있는데](http://stackoverflow.com/questions/12998672/auto-layout-with-custom-uitableviewcell) 아직 만족할 만한 답변이 없음)
* 동작이 되지 않는 정확한 이유는 아직 알 수 없으나, [여기](http://stackoverflow.com/questions/12833176/indentation-not-working-on-custom-uitableviewcell)의 정보를 토대로 분석해 본결과,
	* prototype cell에 더해진 뷰들은 실제로 UITableViewCellContentView의 subview임
	* ratingImageView의 `constraints`를 정할때 UITableViewCellContentView가 아닌 UITableViewCell과의 관계가 정해짐([버그](http://stackoverflow.com/questions/12833176/indentation-not-working-on-custom-uitableviewcell)인듯??)

## SEL은 어디에 선언되어 있는가??

`objc.h` 에 아래와 같이 정의되어 있음
```
typedef struct objc_selector 	*SEL;
```
그렇다면 `objc_selector`는 ??

* [http://www.cocoabuilder.com/archive/cocoa/34093-where-is-defined-sel.html](http://www.cocoabuilder.com/archive/cocoa/34093-where-is-defined-sel.html)
* [http://unixjunkie.blogspot.kr/2006/02/nil-and-nil.html](http://unixjunkie.blogspot.kr/2006/02/nil-and-nil.html). 애플 개발자들이 정말 감추고 싶은 구조체. 더 이상 궁금해 하지 말자 ㅋ
* 크게 관련은 없지만 [볼만한 글(개발자 개념잡기)](http://pole2win.tistory.com/entry/Objective-C-cocoa-core-foundation).

## delegate 패턴

tutorial part 2의 `PlayerDetailsViewControllerDelegate` 를 보고 생각해 봤음

* delegate는 객체의 특정 동작을 다른 객체에 위임(다른 객체가 그 일을 하도록)하는 것이다.
	* 위임하는 이유에는 여러가지가 있을 수 있다.
* 어떻게 보면 자바에서 자주 사용되는 listener 인터페이스들과 같다. (프로토콜이 인터페이스니까)

delegate 패턴을 구현하려면 다음과 같이 생각해 나가면 되겠다.

* 위임하고자 하는 동작(메소드)를 정의한다.
* 해당 메소듣들을 묶어 `*Delegate` 프로토콜을 정의한다.
* `*Delegate` 를 구현한 클래스를 참조할 수 있는 변수 `id<*Delegate>`를 선언한다.
* `id<*Delegate>` 변수를 통해 위임할 메시지를 전달한다.
* `*Delegate`를 구현한다.
* `id<*Delegate>`를 세팅한다.

## send message to nil

nil에 message를 보내도 크래쉬되지 않는다!!. 어떻게 보면 자바스크립트와 약간 비슷한데, nil에 메시지를 보내도 ios 앱은 크래시 되지 않는다.
nil에 메시지를 보내면 그냥 0이 리턴된다. 그래서 많은 경우 objective-c에서는 java에서 자주 사용되는 null 체크 구문이 필요하지 않다.

또한, [nil은 어떠한 selector에도 반응할 수 있는 객체](http://stackoverflow.com/a/310215/588388) 라 할 수 있다.
그래서 아래의 코드를 실행하면 "self.delegate is nil" 이 출력된다.
```
// self.delegate == nil 일때,
if (![self.delegate performSelector:@selector(somemethod)]) {
	NSLog(@"self.delegate is nil");
}
```

---------------------------------------------

## NS_AVAILABLE_IOS 매크로

해당 메소드가 ios 어느 버전부터 사용이 가능한지 나타낸다.

* NS_AVAILABLE_IOS 매크로는 `NSObjCRuntime.h`에 선언되어 있다. (`Availability.h`, `AvailabilityInternal.h`도 참고)
* [SDK Based Development](https://developer.apple.com/library/mac/#documentation/developertools/conceptual/cross_development/Introduction/Introduction.html#//apple_ref/doc/uid/10000163-BCICHGIE)에 이 매크로를 사용해 어떤 플랫폼과 SDK에서 해당 클래스, 메소드의 수행여부를 결정하는지 간략하게 설명되어 있다.
	* 이 글에서는 주로 weaked link된 프레임워크를 사용하는 내용이 주로 설명되어 있는데, (strong linked 되면 컴파일때 다 걸러낼 수 있어서??) 프레임워크를 weaked link 하는 법은 [여기](http://stackoverflow.com/questions/6480765/how-do-i-weak-link-frameworks-on-xcode-4) 설명되어 있다.

NS_AVAILABLE_IOS 는 실제로 다음과 같이 정의되어 있다.

```
define NS_AVAILABLE_IOS(_ios) __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_##_ios)
```

* 음 대충 `__MAC_NA` 는 알겠는데, `__IPHONE_##_ios` 이놈은 뭔가??
	* `##` 은 두개의 토큰을 연결해 준다. ([참고](http://www.mikeash.com/pyblog/friday-qa-2010-12-31-c-macro-tips-and-tricks.html))
	* 즉 `NS_AVAILABLE_IOS(_ios)`의 인자로 전달된 값과 `__IPHONE_`을 연결해 `__IPHONE_6_0` 가 정의된다.
	* 그리고 `Availability.h` 에서 `__AVAILABILITY_INTERNAL__IPHONE_6_0` 가 만들어지며,
	* 마지막으로 `AvailabilityInternal.h` 에서 `__attribute__((availability(ios,introduced=6.0)))` 로 치환된다.

`__attribute__` 는 뭘까?

GNU C 에서 주로 사용하는 옵션으로 메소드나 구조체의 속성([pack 속성](http://kldp.org/node/3518))을 정의하는 매크로이다. LLVM에서는 약간 다르게 형태로 사용된다. 
이놈은 LLVM에서도 clang이 처리하는데 ~~지금 [관련 페이지](http://clang.llvm.org/docs/LanguageExtensions.html) 가 접속이 되지 않는다.~~ 이에 관해서는 아래 링크 참조

* [Clang Compiler User’s Manual](http://clang.llvm.org/docs/UsersManual.html#introduction)
* [Availability attribute](http://clang.llvm.org/docs/LanguageExtensions.html#availability-attribute)

## define NS_DEPRECATED_IOS(_iosIntro, _iosDep) 매크로

비슷하게 이놈도 파봤다. 결국엔 `AvailabilityInternal.h`에서 `__attribute__((deprecated))` 로 치환된다.

다음과 같이 특정 메소드나 속성에 추가하면 컴파일 타임에 llvm이 어느 버전에서 deprecated 되었는지 알려준다.

```
@property (nonatomic,weak) id<PlayerDetailsViewControllerDelegate> delegate NS_DEPRECATED_IOS(3_0,4_0);
```

## iOS 는 2.0 부터 있다??

NS_AVAILABLE_IOS 매크로를 알게된 사실인데 1.0이 없다 :confused:

## Derived Data

xcode를 통해 프로젝트를 생성해 빌드하면 빌드 중간과정에 생긴 파일들이나, 빌드 결과물 (*.app)이 프로젝트 path내에 없다는 것을 알 수 있다.

어디있냐고? `Organizer > Projects` 의 각 프로젝트에 `Derived Data`의 path를 살펴보자.

## Segue

`+` 버튼을 `ctrl + drag` 로 `PlayerDetailView`에 연결할 때, 아래의 코드가 생성된다.

```
<barButtonItem key="rightBarButtonItem" systemItem="add" id="1dC-EI-SvY">
	<connections>
		<segue destination="qz1-xP-cq2" kind="modal" identifier="AddPlayer" id="qgD-pn-5Ji"/>
	</connections>
</barButtonItem>
```

위의 정보를 바탕으로 segue 오브젝트가 생성되어 동작이 수행된다.

참고로, 아래와 같이 segue의 동작을 block으로 커스터마이즈 할 수 있는 메소드가 있다.

```
+ (id)segueWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination performHandler:(void (^)(void))performHandler NS_AVAILABLE_IOS(6_0);

```

## what is "First Responder" ??

다음의 코드에서 도대체 무슨 일이 일어나는 걸까??

```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        [self.nameTextField becomeFirstResponder];
}
```

## emoji

`github`에서도 [emoji](http://www.emoji-cheat-sheet.com/) 를 사용할 수 있다. :joy: