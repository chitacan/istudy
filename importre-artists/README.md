#ARC - Automatic Reference Counting

더이상 `retain`, `release`, `autorelease` 필요 없다.

ARC가 활성화되면 컴파일러가 자동으로 `retain`, `release`, `autorelease`를 컴파일러가 정확한 곳에 꽂아준다.
신경쓰지마라.

ARC는 objc 컴파일러 피쳐다. 따라서 빌드할 때 모든게 일어난다.

ARC는 weak 포인터를 빼면 런타임 피쳐가 아니다. 또 garbage collection도 아니다.


## weak pointer
두 객체가 부모 자식 관계일 때 유용하다.

부모는 strong pointer로 자식을 가리킨다. 자식의 오너다.

하지만 ownership 사이클을 방지하기위해서다.

역으로 자식은 부모를 weak pointer로 가리킬 뿐.

delegate pattern이 좋은 예.

view controller는 `self.view(예: UITableView)`를 strong pointer를 통해 소유할 수 있다.

테이블뷰의 data source, deleage는 반대로 view controller를 가리킨다(weak pointer).

ARC 두 번째 튜토리얼 훑어보니 예제가 있는 듯.


## 제약사항
ARC는 objc 객체에 대해서만 동작한다.

Core Foundation이나 malloc, free를 사용한다면, 메모리 관리를 해야한다.
Core Foundation은 뭐길래?!

너무 밑지마라. 객체가 할당된 상태로 계속 붙들고 있으면 ARC는 절대 release 하지 않는다.

그니까, 새 객체를 어디서 생성하든, 누가 소유하고 있는지 생각할 것이며 그 객체가 얼마나 먹고 살아야하는지 생각할 필요가 있다.
