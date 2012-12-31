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
기존에 NSString 클래스를 @"" 으로 바로 생성할 수 있었는데, 최근에 몇가지가 더 추가되었다.

* 참고링크 : [Objective-C Literals](http://clang.llvm.org/docs/ObjectiveCLiterals.html), [Objective-C Literals, Part 1](http://blog.bignerdranch.com/398-objective-c-literals-part-1/)
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

## Auto resizing과 Constraints