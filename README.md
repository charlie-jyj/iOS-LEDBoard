###  LED 전광판

#### 1) 사용 기술
- UINavigationController
- 화면 전환 개념
- ViewController Life Cycle
- 화면 간 데이터 전달
- 에셋 카탈로그 (프로젝트에 각종 리소스 추가)

#### 2) 기본개념

##### (1) content view controller
- 화면을 구성하는 뷰를 직접 구현하고 관련된 이벤트를 처리하는 뷰 컨트롤러

##### (2) container view controller
- 하나 이상의 child view controller 를 가지고 있다
- 하나 이상의 child view controller 를 관리하고 레이아웃과 화면 전환을 담당
- 화면 구성과 이벤트 관리는 child view controller 에서 한다
- container view controller 는 대표적으로 “Navigation controller” 와 “TabBar Controller” 

##### (3) navigation view controller
계층 구조로 구성된 content 를 순차적으로 보여주는 container view controller

- stack
- root view controller
- push pop
- 화면 상단에 항상 navigation bar 가 보인다 (자식 view controller 마다 navigation bar 를 만들 수 있다)

##### (4) 화면 전환 개념

- 소스 코드를 통해 전환
- storyboard를 이용해 전환

소스 코드를 통해 전환하기

- view controller 의 view 위에 다른 view 를 가져와 바꿔치기
메모리 누수 이슈 있으므로 지양한다


- view controller 에서 다른 view controller 를 호출하여 전환
Presentation 방식
https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present
비동기식으로 이루어지기 때문에 3번째 매개변수로 클로저를 넘겨서 실행이 종료 되었을 때의 액션을 지정할 수 있다.**
Present method
Dismiss method


- navigation controller 를 사용하여 화면 전환
https://developer.apple.com/documentation/uikit/uinavigationcontroller
https://developer.apple.com/documentation/uikit/uinavigationcontroller/1621887-pushviewcontroller/
Pushviewcontroller method
Popviewcontroller method



- 화면 전환용 객체 세그웨이 (segueway) 를 사용하여 화면 전환
두 개의 뷰컨트롤러 사이에 연결된 화면 전환 객체
출발지와 도착지 지정
따로 소스 코드 사용하지 않고 스토리보드로 화면 전환

    - Action segueway : 출발점이 버튼, 셀 등인 경우 (trigger segueway)

    - Show : navigation controller 가 설정되어 있을 때에는 내비게이션 스택에 목적지 뷰를 push 한다. 오른쪽으로 왼쪽으로 슬라이드 되며 나타나고 뒤로가기 버튼이 생성된다. 
    내비게이션 컨트롤러가 없을 경우 present modally 가 적용된다. 

    - Show detail : ipad의 경우 master slave 관계의 split 된 화면으로 보여주게 됨
    - Present modally : 이전 뷰를 덮으며 새로운 뷰 (프레젠테이션 방식), 하단에서 상단으로 끌어올리며 모달을 만든다.
    - Present As popover: iPad 에서 사용, 팝업 창
    - custom 

https://stackoverflow.com/questions/26287247/what-are-the-differences-between-segues-show-show-detail-present-modally


Manual segueway : 출발점이 뷰컨트롤러 자체인 경우 (perform segue 를 통해 이루어짐)
https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performsegue/

##### (5) viewController Life Cycle
알맞은 타이밍에 view 가 나타나게 하자
자동 호출 되는 메서드들이 존재

##### (6) 화면 간 데이터 전달하기

- push, present 되는 view 에 데이터 전달하기
    - a. vc2에 label을 IBOutlet으로 등록
    - b. vc2에 var name 선언 
    - c. vc1 에서 present 되는 viewController 를 instantiate 할 때, vc2 로 다운캐스팅 (as?)
    - d. 다운캐스팅 했기 때문에 vc2 객체에서 멤버에 접근할 수 있음, present 하기 전에 값 전달
    - e. vc2 에서 적절한 시점에 전달받은 (vc1에 의해 변경된) 변수 값을 화면에 반영 (viewDidLoad)

- pop, dismiss 하며 view 에 데이터 전달하기

```
*delegate pattern
iOS에서 자주 사용되는 디자인 패턴

a. Vc2 에서 protocol 을 선언한다. (메세지를 전달하는 sendData 함수를 가진)
b. Vc2 에서 해당 protocol 을 type으로 하는 delegate 변수를 member 로 선언한다. (Prop) (나는 위임자가 있다라는 표시)
    메모리 누수 방지를 위해 weak 예약어 포함*
c. Vc1 에서 present 하기 전에 자신이 위임자임을 밝힌다. Vc2.delegate = self (vc2의 위임자는 나다) 
d. 위의 과정을 위해서는 protocol을 채택해야 하며, 함수 구현 한다. (전달 받은 메세지를 처리하는)
e. Dismiss 하기 전에 delegate의 함수를 호출한다 (전달할 메세지를 args 로 전달)
```

- segueway 로 데이터 전달하기

A. Vc1 에서 prepare 메서드를 override (세그웨이 호출 직전에 자동으로 call)
B. seque.destination 객체를 vc2 로 다운캐스팅 한 후, 멤버에 접근하여 값을 전달한다.

##### (7) 이미지 asset
assets.xcassets 를 통해 관리
1x : 24px
2x: 48px 
3x: 72px


##### 3) 새로 배운 것들

- navigation view controller 를 library 에서 검색하여 추가할 수 있다. 기존의 root 를 삭제한 후에 다른 view 를 root 로 변경할 때에는 우클릭 드래그 할 것
- 스토리 보드에서 viewcontroller 를 생성한 후에 이를 클래스에 추가할 수 있다.
- 프로젝트 폴더에서 new file > cocoa touch 파일 생성 > type 을 view controller 로 하는 파일을 생성한 후 > 스토리보드의 identity inspector에서 연결해줄 것
- 버튼 선택을 통해 화면 이동을 할 경우 해당 버튼 우클릭 드래그 하여 segueway 를 추가할 수 있다.
- ui object 는 option 키를 누른채로 드래그하면 복사할 수 있다
- Scene 안에서 목록 선택 후 ctrl c ctrl v 해도 복붙 가능
- ui object 들을 다중 선택한 후에 stack view 로 묶어 하나의 그룹으로 만들 수 있다 (그룹화)
- 하나의 버튼에 IBAction을 연결한 후에 다른 버튼들을 같은 함수에 연결할 수 있다. (우클릭+드래그)
- argument 앞에 있는 underscore :  https://stackoverflow.com/questions/39627106/why-do-i-need-underscores-in-swift (label name: Int) 에서 label 이 생략된 것으로 보면 된다.
- optional 인데 nil 이면 default 값 주기 : ?? Default value





