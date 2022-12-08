//
//  MenuListViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송선진 on 2022/10/28.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MenuListViewModel {
    
    /*
     Stream 생성하기
     
     1. menuObservable 생성: [Menu] -> PublishSubject<[Menu]> 타입으로 변경
     2. itemsCount 생성: menuObservable에서 count 합산한 숫자로  Observable<Int> 타입으로 생성
     3. totalPrice 생성: menuObservable에서 price * count 합산한 숫자로 Observable<Int> 타입 생성
     
     결국, [Menu] 에서 menuObservable, itemsCount, totalPrice 가 연쇄적으로 생성되며 Stream 을 이루었음.
     [Menu]의 요소가 바뀌면 -> 자동적으로 menuObservable, itemsCount, totalPrice가 업데이트됌.
     */
    
    /*
     - menus 또한 BehaviorSubject<[Menu]> 타입으로 변경해, menus의 요소인 name, price, count 가 변할때마다 밑에 menuObservable을 이용한 totalPrice, itemsCount가 자동으로 호출되어 작동. menuObservable는 BehaviorSubject이기 때문에 외부에서 접근 가능하도록 만듦.
     
     - PublishSubject가 아닌 BehaviorSubject로 만든 이유 :
        -> publishSubject는 새로운 데이터가 넣어줘야 subscribe 했을 때 전달이 되는 형태.
        -> 만약 menuObservable을 publishSubject 타입으로 지정했다면, Init()에서 onNext로 데이터를 전달해주고 viewController에서 subscribe 했을 때 데이터 전달이 안됌. menus에 새로운 데이터가 들어왔을 때 or onNext했을 때 subscribe해야 데이터 전달 가능
        -> behaviorSubject는 subscribe 시 새로운 데이터가 들어오지 않았다면 가장 마지막 데이터를 전달해주는 타입. 그러므로 init()에서 onNext로 데이터 전달해주고, viewController에서 subscribe해도 가장 최근 데이터인 onNext 데이터를 전달해줌.
     
     */
    
    
    lazy var menuObservable = BehaviorRelay<[Menu]>(value: [])
    
    // MenuList페이지 맨 밑에 있는 총 items 개수와 총 금액
    lazy var itemsCount = menuObservable.map {
        $0.map { $0.count }.reduce(0, +)
    }
//     .scan(0, accumulator: +): 0부터 시작해서 새로운 값이 들어오면 기존 값과 더하겠다(+)
    
    // lazy var totalPrice: Observable<Int> { get set } 으로 값이 변하면 자동 호출
    lazy var totalPrice = menuObservable.map {
        $0.map { $0.price * $0.count }.reduce(0, +)
    }
    
    /* Subject / Relay
     Subject : Observable처럼 값을 받아올 수도 있지만, 외부에서 값 컨트롤도 가능
     
     -> Observable은 create 할때부터 어떤 데이터를 전달할지 정해지기 때문에 외부에서 데이터를 주입하거나, 변경하는 것이 불가한 단방향.
     -> Subject는 외부에서 값 컨트롤이 가능한 양방향.
     
     - 정의) var totalPrice: PublishSubject<Int> = PublishSubject()
     - 정의) var menuObservable = BehaviorSubject<[Menu]>(value: [])
        -> BehaviorSubject는 create부터 기본값 가짐.
     
     
     
     Relay: Subject랑 종류부터 기능까지 모두 동일. 하지만 다른점은 Error 발생시 Stream이 끊어지지 않고 계속 이어짐.
     
     -> Relay는 에러가 발생하지 않으니, onNext 만! 있음.
     -> Relay에서는 onNext를 .accept 로 표현
     
     
     */
    
    init() {
        // Observable<Data> 타입을 decoding 
        let DataDecoding = APIService.fetchAllMenusRx()
            .map { data -> [MenuItem] in
                struct Response: Decodable {
                    let menus: [MenuItem]
                }
                let response = try! JSONDecoder().decode(Response.self, from: data)
                
                return response.menus
            }
        
        _ = DataDecoding.map { menuItems -> [Menu] in
            var menus: [Menu] = []
            menuItems.enumerated().forEach { (index, item) in
                let menu = Menu.fromMenuItems(id: index, item: item)
                menus.append(menu)
            }
            return menus
        }
        .take(1)
        // 우리 app에서 사용할 실질적 data type인 <Menu>로 DataDecoding를 변환하고, 이 값을 menuObservable에 바인딩 해줌.
        .bind(to: menuObservable)
    }
    
    func onOrder() {
        
    }
    
    func clearAllItemsSelections() {
        _ = menuObservable
            .map { menus in
                return menus.map { menu in
                    Menu(id: menu.id, name: menu.name, price: menu.price, count: 0)
                }
            }
            .take(1)
            /*
             .take(1) : clear 버튼을 누르면 누를 때마다 새로운 stream이 계속 생성. 이 stream은 한번만 사용하고 끝낼것이라는 의미로 .take(1) 작성. 한번 사용 후 없어지기 때문에 disposed 할 필요가 없음.
             */
            .subscribe(onNext: {
                self.menuObservable.accept($0)
            })
    }
        
    
    func changeCount(item: Menu, increase: Int) {
        _ = menuObservable
            .map { menus in
                menus.map { menu in
                    if menu.id == item.id {
                        return Menu(id: menu.id,
                             name: menu.name,
                             price: menu.price,
                             count: max(menu.count + increase, 0))
                    } else {
                        return Menu(id: menu.id,
                             name: menu.name,
                             price: menu.price,
                             count: menu.count)
                    }
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.menuObservable.accept($0)
            })
    }
}
