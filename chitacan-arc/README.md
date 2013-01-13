# ARC

## 요약

### 기본정보

* `ARC` 는 objective-c 컴파일러 (LLVM clang) 의 feature.
* 즉 `ARC`와 관련된 대부분의 기능들은 컴파일 타임에 동작한다.
	* 즉 ARC는 gc와 같이 런타임에 메모리를 관리해주는 그런 기능이 아니다.
* `ARC`는 컴파일 타임에 `retain`, `release`와 같은 코드를 컴파일러가 넣어준다.

### Strong vs Weak

* 포인터 타입에는 `strong`과 `weak`가 있다. 둘의 차이는 가리키는 object의 소유여부이다.
	* `strong` 타입의 포인터는 가리키는 object를 소유한다.
	* `weak` 타입 포인터는 가리키는 object를 소유하지 않으며, object가 deallocated 되면 자동으로 `nil`로 변한다.
* objective-c에서 기본적으로 모든 포인터는 `strong` 포인터이다.
* 기본적으로 owner가 없는 object는 바로 deallocated 된다.
* `weak` 포인터는 보통 ownership cycle (서로가 서로를 `strong` 타입의 포인터로 참조하는) 이 발생하는 케이스에 유용하다.
	* 특히, delegate 패턴에서 유용함

### ARC의 한계

* `ARC`는 objective-c object 에만 사용할 수 있다.

## UITableViewDataSource protocol

아래의 코드를 통해, `UITableViewDataSource` protocol 의 메소드들은 UITableView의 `setDataSource`가 실행되면서
관련된 메소드들의 구현여부 체크하는 것을 확인할 수 있다.

```
- (BOOL) respondsToSelector:(SEL)aSelector {
    NSLog(@"%@", [NSThread callStackSymbols]);
    NSLog(@"%@", NSStringFromSelector(aSelector));
    return [super respondsToSelector:aSelector];
}
```

위 코드의 호출과정에서 nib 파일이 실제 인스턴스화 되어 코드와 연결되는 것으로 생각되는 stack trace도 출력되었는데
한번 살펴볼만 하다.

```
2   Foundation                          0x010b4e8e _NSSetUsingKeyValueSetter + 82
3   Foundation                          0x010b49b7 -[NSObject(NSKeyValueCoding) setValue:forKey:] + 267
4   UIKit                               0x0061e573 -[UIView(CALayerDelegate) setValue:forKey:] + 168
5   Foundation                          0x010df428 -[NSObject(NSKeyValueCoding) setValue:forKeyPath:] + 412
6   UIKit                               0x007eb0cc -[UIRuntimeOutletConnection connect] + 106
7   libobjc.A.dylib                     0x01edb663 -[NSObject performSelector:] + 62
8   CoreFoundation                      0x017ea45a -[NSArray makeObjectsPerformSelector:] + 314
9   UIKit                               0x007e9bcf -[UINib instantiateWithOwner:options:] + 1327
10  UIKit                               0x006aee37 -[UIViewController _loadViewFromNibNamed:bundle:] + 280
11  UIKit                               0x006af418 -[UIViewController loadView] + 302
12  UIKit                               0x006af648 -[UIViewController loadViewIfRequired] + 73
13  UIKit                               0x006af882 -[UIViewController view] + 33
```

## AFHTTPRequestOperation 분석

[이번 튜토리얼](http://www.raywenderlich.com/5677/beginning-arc-in-ios-5-part-1) 에 포함된 `AFHTTPRequestOperation` 분석

[AFNetworking](https://github.com/AFNetworking/AFNetworking) 프로젝트에 포함된 클래스인데, 좀 옛날껄 갓다 썼는지, 

현재 깃헙의 소스와는 좀 다르다.

### 시작

* 시작은 사용자가 `search bar`에 검색 내용을 입력하고 `search` 버튼을 클릭하면서다.