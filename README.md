# iOS_juice_maker
----

<a href ="#1-Step1---쥬스 메이커 타입 정의">Step1 - 쥬스 메이커 타입 정의</a>   
<a href ="#2-Step2---초기화면 기능구현">Step2 - 초기화면 기능구현</a>   
<a href ="#3-Step3---재고 수정 기능구현">Step3 - 재고 수정 기능구현</a>   

----
## 🗂️ 프로젝트 파일 구조
<img src = "https://user-images.githubusercontent.com/45708630/210944976-ffe0afcd-d73e-478b-ad73-efb36373d22a.png" width=1000 height=400>

---
## 🔖 역할 분배
|enum|역할|
|:---|:---|
|`Fruit`|과일 리스트를 Case별로 나누었습니다.|
|`SingleFruitJuice`|한 가지 종류의 과일 쥬스를 만들 수 있는 Case별로 나누었습니다.|
|`MixFruitJuice`|두 가지 종류의 과일 쥬스를 만들 수 있는 Case별로 나누었습니다.|
|`StockError`|재고가 없을 때 에러메세지를 출력할 수 있도록 Case별로 나누었습니다.|

|protocol|역할|
|:---|:---|
|Makeable|`JuiceMacker`가 제조하는 역할만 할 수 있도록 메서드를 정의하였습니다.|
|Computable|`Calculator`가 계산기처럼 사칙연산의 역할만 할 수 있도록 메서드를 정의하였습니다.|
|SendDataDelegate|`FruitViewController`에서 초기 재고 값을 보여줄 수 있도록 메서드를 정의하였습니다.|

|struct & Class|역할|
|:---|:---|
|`JuiceMaker`|제일 상위 모듈로 ViewController에서 요청하는 행위를 진행할 수 있도록</br> 구현하였습니다.|
|`FruitStore`|Singleton 패턴을 적용하여 재고관리를 진행하는 클래스 타입의 모델입니다.|
|`Calculator`|SOLID의 DIP에 맞추어 계산기 역할을 할 수 있도록 구현된 클래스 타입의 모델입니다.|

|Controller|역할|
|:---|:---|
|`JuiceViewController`|`JuiceMaker` 실행 시 보이는 `View`를 핸들링하는 `Controller` 입니다. 각 과일별 재고수량을 보여주고, 쥬스를 제조할 수 있는 버튼을 갖고 있습니다.|
|`FruitViewController`|쥬스를 만들 과일의 수량이 부족하거나 재고의 수정이 필요할 때 사용하는 `View`를 핸들링하는 `Controller` 입니다. 각 과일의 현재 재고수량을 확인하고, `Stepper`를 통해 그 수를 조정할 수 있습니다.|

---

## Step1 - 쥬스 메이커 타입 정의
[PR #26 | Step1 - 쥬스 메이커 타입 정의](https://github.com/tasty-code/ios-juice-maker/pull/26)

- Singleton Desing Pattern을 사용하여 과일의 재고를 관리하는 FruitStore 타입 정의
- ViewController의 request를 받아 주문서에 맞는 음료 제조를 역할을 하는 JuiceMaker 타입 정의

관리하는 과일의 종류로는 딸기, 바나나, 파인애플, 키위, 망고 총 5가지를 가지고 있으며 각 과일 종류마다
할당되는 초기 재고수량은 10개로 정의한다.
FruitStore 객체는 전체 재고 수량을 조절해야하기 때문에 ViewController에서 `재고 수정` 버튼으로
요청이 들어올 때 수량을 n개 변경하는 기능을 구현하였다.

JuiceMaker는 FruitStore를 소유하고 있어 공유자원을 통해 음료를 제조할 수 있으며
`startMake(single:)`과 `startMake(mix:)`를 통해 어떤 음료를 주문받는지 분기할 수 있으며
`requestTo(single:)`과 `requestTo(mix:)`를 통해 주문 받은 과일의 종류를 알려주면 하나의 메서드 안에서 제조할 수 있도록 하였습니다.
reqeust 메서드 안에는 주문 받았을 때 과일의 재고가 부족하면 기존 재고를 유지하고 제조할 수 없다는
메세지를 출력합니다.
    
### 🚀 적용해보려고 노력해본 점

#### 1. 프로토콜 채택
- Model/Protocol 내 채택할 프로토콜 파일 생성
- Makeable.swift, Computable.swift
```Swift
protocol Makeable {}
protocol Computable {}
```
JuiceMaker, Calculator에서 모든 코드를 작성/수정하는 것이 아니라 프로토콜을 사용함으로써 기능의 변동사항이 발생 시 반영을 쉽게 했습니다.
실제 Calculator는 처음에 add, subtract만 기능하였는데 compare 메서드가 필요했을 때 채택했던
Computable에 추가하여 바로 반영이 가능했습니다.
또한 이렇게 프로토콜을 채택하면서 각각이 필요한 기능만 하도록 제약하여 역할의 분리를 꾀할 수 있었습니다.

#### 2. 중복되는 코드 메서드화

JuiceMaker의 requestTo 메서드는 처음에 각 Single Fruit Juice, 각 Mix Fruit Juice에 있었습니다.
그러나 과일 유형만 다르고 코드가 동일했기 때문에 forEach를 사용하여 하나의 메서드로 통합할 수 있었습니다.

---
## Step2 - 초기화면 기능구현
[PR #40 | Step2 - 초기화면 기능구현](https://github.com/tasty-code/ios-juice-maker/pull/40)
- `재고 수정` 버튼을 통한 화면 전환을 present Modally로 구현
- `쥬스 주문` 버튼을 통한 재고 부족 Alert에서 `예` 선택 시 재고 수정 화면으로 전환 (위와 동일)
- 초기 화면의 View가 올라오면 과일 타입마다 10개씩 보이도록 Label 구현

재고 수정 화면 전환을 위해 Storyboard에서 `NavigationController`를 사용하여 
BarButtonItem의 `RightButton`을 통해 `Action Segue` 형식을 `Present Modally`방법을
사용해서 전환이 이루어지도록 하였다.

쥬스 주문 버튼을 통해 필요한 갯수만큼 소모되고 이후 Alert으로 쥬스가 나왔음을 표시한다.
재고가 더이상 쥬스를 제조할 수 없을만큼 존재하면 쥬스를 제조할 수 없다는 Alert을 표시하며
주문을 취소할지(`아니오` 버튼) 재고를 수정할지(`예` 버튼) 선택할 수 있도록 하였고 재고를 수정한다면
NavigationController에 사용했던 방식과 동일하게 작동하여 화면을 전환한다.
### 🚀 적용해보려고 노력해본 점
NavigationController에서 화면 전환을 어떤 방식으로 할지 총 5가지의 방법이 있다.
- Show
- ShowDetail
- Present
- Presetn Modally
- Custom
하나씩 연결해 보았을 때 제일 많이 사용되는 `Show` 방식을 채택하여 화면을 뒤로갈 수 있는 버튼이
자동생성되는것을 확인하였다. 그 다음 Step3에서 진행되는 방식을 확인했을 때 Modal 형식으로 되어있었고
하여 `Present Modally`를 선택하였고 이후 쥬스 주문 버튼에서 `예` 버튼을 사용하였을 때
Alert의 Present 방식을 Modally로 사용하여 동일한 화면전환을 이루게하였다.
```Swift
private func presentModally() {
        guard let fruitNavigationController = self.storyboard?.instantiateViewController(identifier: "FruitNavi") as? UINavigationController else { return }
        fruitNavigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(fruitNavigationController, animated: true, completion: nil)
    }
```


---
## Step3 - 재고 수정 기능구현
[PR #40 | Step3 - 재고 수정 기능구현](https://github.com/tasty-code/ios-juice-maker/pull/40)
- NavigationBar의 Title을 `재고 추가`로 구현하고 `BarButtonItem`으로 `닫기`버튼 구현
- Storyboard에서 Auto Layout을 사용하여 화면 배치
- Stepper를 이용하여 재고 수량을 조절할 수 있도록 구현

각각의 과일 이미지를 보여주는 `UILabel`과 재고수량을 보여주는 `UILabel`을 `Outlet Collection`으로, 스텝퍼는 하나의 `IBAction`으로 그룹화 하여 작업을 시작했다.
`Delegate`에 `FruitViewController`의 재고 label initialize를 진행하는 `syncFruitStocks` 메서드를 담아 화면 전환이 되었을 때 기존 재고가 표시되도록 하였다.
이후 `Stepper`로 증감한 수를 재고에 업데이트 할 수 있었다.

### 🚀 적용해보려고 노력해본 점
- Delegate (Jason)
ViewController간에 데이터를 전송하는 기본적인 방식으로 present 메서드와 Segue를 이용하여 전송하는 방법으로 진행해보려고 했다.
구현과정 중 실제로 재고수정 버튼을 푸쉬하였을 때 값이 잘 넘어갔었지만 Label의 레이아웃이 잡히지 않아서 값을 확인하는 과정에 오해가 있었고 이후 Delegate를 사용하여 잘풀어냈다.

- modalPresentationStyle (Jason)
화면 전환 시 NavigationController를 사용하여 화면 전환을 할 때와 마찬가지로 Alert을 이용하였을 때도 동일한 방법으로 전환되지 않았던 문제를 아래와 같은 코드로 구현하여 해결하였다.
(NavigationController를 사용할 때 present Modally 방식으로 Action Segue를 주었다.)
```swift
private func presentModally() {
        guard let fruitNavigationController = self.storyboard?.instantiateViewController(identifier: "FruitNavi") as? UINavigationController else { return }
        fruitNavigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(fruitNavigationController, animated: true, completion: nil)
    }
```

### 🎯 트러블슈팅
delegate를 프로퍼티로 갖게 되는 부분이 SecondViewController(FruitViewController)
```Swift
weak var delegate: SendDataDelegate?
```
-> 일을 시키는 쪽(First View)에서는 IBAction과 같이 present로 화면 전환을 이루는 코드 영역에서 delegate를 연결해준다.   

SecondViewController → delegate 변수를 갖고있어서
```
delegate.메서드명 → 이렇게 프로토콜에 정의된 메서드를 사용할 수 있다.
```

🤔 FirstView가 Delegate 프로토콜을 채택하는 이유?   
FirstView의 형변환을 통해 self 키워드를 사용해서 연결해준다.   
Delegate 프로토콜을 채택한 FirstView에는 SecondView에서 delegate를 포함하는 메서드가 있고,   
delegate가 프로토콜 메서드를 호출할 때 실행되어야 할 프로토콜에 정의된 메서드를 작성해야한다.

→ 이렇게 FirstView에서 작성한 함수를 통해 SecondView에서 delegate를 포함한 메서드가 실행되어 일을 시키면   
FirstView가 그 일을 대신해서 일을 수행하게된다.

→ SecondView의 위임자는 일을 시킬 뿐 어떤 일을 하는지에 대한 구체적인 내용을 모른다!

---

## Step1 실행화면
<img src="https://user-images.githubusercontent.com/92699723/210941422-16c25bf6-6bdb-4239-ae0b-39853c1697ea.png" width=500>

## Step2 실행화면
<img src="https://user-images.githubusercontent.com/45708630/212285108-37a684ff-2c32-450c-9594-95af4d4e33c5.png" width="360">

<img src="https://user-images.githubusercontent.com/45708630/212287312-fe4b15b5-f1eb-4eed-9167-54697b9396c4.png" width="360">

<img src="https://user-images.githubusercontent.com/45708630/212287423-e50cccac-9140-4886-979a-f9a9174853c3.png" width="360">

## Step3 실행화면
<img src = "https://user-images.githubusercontent.com/92699723/215018499-6606d950-f473-4f24-a008-b8cdc79eded6.gif" width="360">
