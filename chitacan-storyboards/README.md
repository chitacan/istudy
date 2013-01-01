# Stroyboards

## Instance Variables in the Implemetation file

* 이번 tuts를 진행하다보니 아래와 같이 instance variable을 선언해보라는 내용이 있었다.

```
@implementation AppDelegate {
	NSMutableArray *players;
}
```

* 컴파일 에러가 떨어지지 않아서 이래도 되나 했는데, 정확하게 왜, 어느 경우에 사용할 수 있는지를 몰라 검색해 보았음
* [이곳](http://mobiledevelopertips.com/objective-c/instance-variables-in-implementation-file.html)의 내용을 정리해 보면
	* instance variable을 implementation file에 선언할 수 있는건 LLVM 컴파일러 때문 (오!! :smirk:)
	* 이를 활용하면 실제로 사용하고 public 으로 사용할 변수면 interface 에 공개할 수 있어 유용하다.

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



## emoji

`github`에서도 [emoji](http://www.emoji-cheat-sheet.com/) 를 사용할 수 있다. :joy: