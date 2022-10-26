//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//
// 49:46

import RxSwift
import SwiftyJSON
import UIKit

let MEMBER_LIST_URL = "https://my.api.mockaroo.com/members_with_avatar.json?key=44ce18f0"

class ViewController: UIViewController {
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var editView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }

    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    // 자. 여기서의 궁금증. 비동기 코드를 completion이 아닌 return 값으로 줄 순 없을까? 그게 RXSwift
    // 1. 비동기로 생기는 데이터를 Observable로 감싸서 리턴하는 방법
    func downloadJson(_ url: String) -> Observable<String?> {
        // RXSwift : 비동기적으로 나중에 생성되는 데이터를 return 값으로 전달해주는 utility
        // Observable<String> : 나중에 생길 데이터, subscribe : 나중에 데이터 나오면 실행되는 것
        return Observable.create() { emitter in
            let url = URL(string: url)!
            // URLSession은 자체적으로 비동기 처리
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil else {
                    emitter.onError(error!)
                    return
                }
                
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    emitter.onNext(json)
                }
                emitter.onCompleted()
                /* 클로저 내 순환참조
                 
                 f.onCompleted() : 아래 subscribe 클로저 안에서 순환참조 문제가 발생하게 됌
                 <해결 방법>
                 1. subscribe 클로저 안에서 [weak self] 사용
                 2. f.onNext 다음에 f.onCompleted() 실행 : subscribe 클로저가 생성되면서 reference count가 올라가기 때문에, 클로저를 종료시킴으로써 RC를 줄임. 클로저는 onCompleted()나 onError() 가 실행되면 역할이 끝났다고 판단되어 클로저 자체가 종료됌. 그러므로 weak self를 사용하지 않아도 순환참조가 발생되지 않음.
                 3. disposable.dispose() 하게 되면 함수 실행이 중지되기 때문에 클로저 종료.

                 */
            }
            task.resume()
            
            // subscribe가 취소되었을 때, 행해지는 코드
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    // MARK: - Observable 과 Observer(= subscriber)의 관계
    /*
     참고 https://4z7l.github.io/2020/12/03/rxjava-2.html
     Observable이 데이터를 발행하고(Create) -> 알림(Event)를 보내면 -> Observable을 구독하고 있는 Observer들은 데이터를 소비(Consume)한다.
     
     - Observable의 생명 주기
        : Create -> Subscribe(실행) -> onNext -> onCompleted / onError -> Disposed
        : 한번 onCompleted / onError 된 subscribe 코드는 재사용 불가. 한번 생성된 Observable에 새로운 subscribe를 주고 재사용해야함.
        : Observable.create() 는 anonymousObservable 리턴
     
     - Observable이 데이터를 발행한 후 보내는 알림
     1. onNext : 데이터의 발행 알림
     2. onComplete : 모든 데이터의 발행 완료 알림. 딱 한번 발생. 이후 onNext 발생하면 안됌.
     3. onError : 오류 발생. 이후 onNext, onComplete 모두 발생 안함.
     
     - Observer의 subscribe : Observable로부터 받은 데이터를 가지고 할 행동들을 정의한 것.
     
     - Disposables : 구독의 해지. onComplete 이벤트 발생하면 Disposables.create() 호출해 더 이상 데이터 발행하지 않도록 구독 해지
        -> 만약 let disposable = downloadJson(MEMBER_LIST_URL).subscribe { event in ~ } 이런 식으로 설정하고 그 다음에 disposable.dispose() 를 실행시키면 subscribe 동작이 다 완료되지 않아도 취소됌.
     
     - 예시)
     func downloadJson(_ url: String) -> Observable<String?> {
        return Observable.create() { emitter in
            emitter.onNext("Hello")
            emitter.onCompleted() // 순환참조 없애기 위해
     
            return Disposables.create()
        }
     }
     */
    
    /* 구 코드 3 : URLSession 사용하지 않고 DispatchQueue 사용하여 직접 비동기 처리
     func downloadJson(_ url: String) -> Observable<String?> {
         return Observable.create { f in
             DispatchQueue.global().async {
                 let url = URL(string: MEMBER_LIST_URL)!
                 let data = try! Data(contentsOf: url)
                 let json = String(data: data, encoding: .utf8)
                 
                 DispatchQueue.main.async {
                     f.onNext(json)
                     f.onCompleted()
                 }
             }
             return Disposables.create()
         }
     }
     */
    
    /* 구 코드2 : completion으로 던지는 함수
     
     func downloadJson(_ url: String, _ completion: @escaping (String?) -> Void) {
     DispatchQueue.global().async {
     let url = URL(string: MEMBER_LIST_URL)!
     let data = try! Data(contentsOf: url)
     let json = String(data: data, encoding: .utf8)
     
     DispatchQueue.main.async {
     completion(json)
     }
     }
     }
     
     @IBAction func onLoad() {
         editView.text = ""
         
         // JSON파일 다운 중에 보이는 뺑뺑이 이미지
         // 아래 코드를 비동기로 처리하지 않는 이유는, UI layout 관련된 코드는 다른 Thread가 아닌 무조건 main Thread에서 처리되어야 하기 때문
         setVisibleWithAnimation(self.activityIndicator, true)
         
         downloadJson(MEMBER_LIST_URL) { json in
             self.editView.text = json
             self.setVisibleWithAnimation(self.activityIndicator, false)
         }
     }
     */

    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBAction func onLoad() {
        editView.text = ""
        setVisibleWithAnimation(self.activityIndicator, true)
        
        // 2. Observable로 오는 데이터를 받아서 처리하는 방법
        let observable = downloadJson(MEMBER_LIST_URL)
        // observable을 subscribe하면 return되는 값 = disposable
        let disposable = observable
                            .debug() // 윗줄과 아랫줄 코드 사이 데이터 이동이 다 찍힘.
                            .subscribe { event in
                                // 위에 Observable<String?>이 나중에 생기면 subscribe 실행
                                switch event {
                                case .next(let json) :
                                    // UI 관련 요소들은 main Thread에서 변경
                                    DispatchQueue.main.async {
                                        self.editView.text = json
                                        self.setVisibleWithAnimation(self.activityIndicator, false)
                                    }
                                case .completed :
                                    break
                                case .error :
                                    break
                                }
                            }
//        disposable.dispose() : disposable을 중지하는 함수
    }
    
    
    /*  구 코드 1
     
     @IBAction func onLoad() {
     editView.text = ""
     
     // JSON파일 다운 중에 보이는 뺑뺑이 이미지
     // 아래 코드를 비동기로 처리하지 않는 이유는, UI layout 관련된 코드는 다른 Thread가 아닌 무조건 main Thread에서 처리되어야 하기 때문
     self.setVisibleWithAnimation(self.activityIndicator, true)
     
     DispatchQueue.global().async {
     let url = URL(string: MEMBER_LIST_URL)!
     let data = try! Data(contentsOf: url)
     let json = String(data: data, encoding: .utf8)
     
     // UI layout 관련 코드이기 때문에 DispatchQueue.main.async 로 메인쓰레드 처리
     DispatchQueue.main.async {
     self.editView.text = json
     self.setVisibleWithAnimation(self.activityIndicator, false)
     }
     }
     }
     
     -> onLoad() 안에 DispatchQueue 등 코드가 지저분함.
     1. 서버에서 통신하는 코드끼리 묶어서 downloadJson 함수 생성 -> 다른 쓰레드에서 작동하기 위해 .global()
     2. UI layout관련 코드도 지저분하기 때문에 downloadJson 안에 넣기
        -> DispatchQueue.global 안에 .main 생성하여 completion으로 던지기
     */
}
