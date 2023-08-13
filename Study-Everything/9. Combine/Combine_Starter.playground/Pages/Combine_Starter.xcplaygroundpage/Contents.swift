import UIKit
import Combine

public func example(of description: String,
                    action: () -> Void) {
  print("\n——— Example of:", description, "———")
  action()
}

var subscriptions = Set<AnyCancellable>()

// MARK: Publisher - NotificationCenter.publisher
// 이 예시는 Publisher이 output을 보내 print문을 출력시킨 것이 아니다. 실제 Publisher가 output을 보내려면 Subscriber가 존재해야 한다.
example(of: "Publisher") {
    // 1. notification name 설정
    let myNotification = Notification.Name("MyNotification")
    
    // 2. NotificationCenter 프로퍼티 생성
    let center = NotificationCenter.default
    
    // 3. publisher 생성
    let publisher = center.publisher(for: myNotification, object: nil)
    
    // 4. observer 추가 : notification을 받을 observer 생성
    let observer = center.addObserver(forName: myNotification,
                                      object: nil,
                                      queue: nil) { notification in
        print("Notification received!")
    }
    
    // 5. name으로 notification 을 보낸다.
    center.post(name: myNotification, object: nil)
    
    // 6. notification center에서 해당 observer를 삭제한다.
    center.removeObserver(observer)
    
    // 이미 notification center에서 해당 observer를 삭제했기 때문에 더 이상의 notification을 수신 받을 수 없다.
    center.post(name: myNotification, object: nil)
}

// MARK: Subscriber - NotificationCenter.sink
example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    let publisher = center.publisher(for: myNotification, object: nil)
    
    // 1. publisher에서 sink를 호출함으로써 Subscription을 생성한다.
    // sink : Combine에 내장되어있는 subscriber 중 하나이다.
    let subscription = publisher.sink { _ in
        print("Notification receibed from a publisher!")
    }
    
    // 2.
    center.post(name: myNotification, object: nil)
    
    // 3. Subscription을 취소한다.
    subscription.cancel()
}

// MARK: Publisher - Just
example(of: "Just") {
    // 1. Just를 사용해 Publisher를 생성한다.
    let just = Just("Hello world")
    
    // 2. sink를 사용해 subscription을 생성하고, publisher로부터 받은 각 이벤트를 print한다.
    _ = just.sink(
        receiveCompletion: {
            print("Received Completion", $0)
        },
        receiveValue: {
            print("Received Value", $0)
        })
}

// MARK: Subscriber - assign(to:on:)
example(of: "assign(to:on:)") {
    // 1.
    class SomeObject {
        var value: String = "" {
            didSet {
                print("SomeObject value 변경: \(value)")
            }
        }
    }
    
    // 2.
    let object = SomeObject()
    
    // 3. 문자열 배열에서 publisher을 생성한다.
    let publisher = ["Hello", "world"].publisher
    
    // 4. assign을 사용해 subscriber을 수행하고, publisher로부터 받은 값을 객체의 프로퍼티에 할당한다.
    _ = publisher.assign(to: \.value, on: object)
}

// MARK: Subscriber - assign(to:)
example(of: "assign(to:)") {
    // 1. @Published: 해당 속성에 대해 Publisher을 생성한다.
    class SomeObject {
        @Published var value = 0
    }
    
    let object = SomeObject()
    
    // 2. @Published 속성 앞에 $를 사용하므로써, Publisher에 접근이 가능해진다.
    // 해당 Publisher에 sink를 사용해 subscribe하고, Publisher로부터 받은 값을 print한다.
    object.$value.sink { print($0) }
    
    // 3. 숫자 배열 Publisher를 생성하고, 해당 Publisher가 방출하는 값을 object의 value Publisher에 할당한다.
    // value라는 해당 속성에 접근하기 위해 inout 키워드인 & 를 사용한다.
    (0..<10).publisher.assign(to: &object.$value)
}

// MARK: assign(to:on:)과 assign(to:)의 비교
example(of: "assign(to:on:) vs assign(to:)") {
    
    // 1. assign(to:on:) : assing을 하고, 그 결과를 subscriptions에다가 저장하는 과정에서 strong reference cycle(강한 참조 순환)이 발생한다.
    // 2. assign(to:) : 강한 참조 순환 문제를 해결할 수 있다.
    class MyObject {
        @Published var word: String = ""
        var subscriptions = Set<AnyCancellable>()
        
        init() {
            // 1.
//            ["A", "B", "C"].publisher
//                .assign(to: \.word, on: self)
//                .store(in: &subscriptions)
            // 2.
            ["A", "B", "C"].publisher.assign(to: &$word)
        }
    }
}


// MARK: KVO
example(of: "KVO") {
    class SomeClass: NSObject {
        @objc dynamic var text: String = "old value"
    }
    
    let someClass = SomeClass()
    
    someClass.observe(\.text) { object, _ in
        print("SomeClass value changed: \(object.text)")
    }
    
    someClass.text = "new value"
}


import UIKit
let stackView = UIStackView()
let view = UIView()

print(view.translatesAutoresizingMaskIntoConstraints)
stackView.addArrangedSubview(view)


//print(stackView.translatesAutoresizingMaskIntoConstraints)
print(view.translatesAutoresizingMaskIntoConstraints)
