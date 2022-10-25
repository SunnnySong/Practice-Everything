//
//  ViewController.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 05/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

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
    
    func downloadJson(_ url: String) -> String? {
        let url = URL(string: MEMBER_LIST_URL)!
        let data = try! Data(contentsOf: url)
        let json = String(data: data, encoding: .utf8)
        return json
    }

    // MARK: SYNC

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

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
}
