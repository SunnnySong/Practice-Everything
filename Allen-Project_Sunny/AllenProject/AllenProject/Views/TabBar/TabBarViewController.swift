//
//  ViewController.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/16.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        
        setupTabBar()
        tabBarConfigure()
    }
    
    private func tabBarConfigure() {
    }
    
    private func setupTabBar() {
        
        let calendar = naviController(image: UIImage(systemName: "calendar.badge.plus"), title: "달력", rootViewController: DateViewController())
        let home = naviController(image: UIImage(systemName: "house"), title: "홈", rootViewController: HomeViewController())
        let lotto = naviController(image: UIImage(systemName: "qrcode"), title: "로또 QR", rootViewController: LottoViewController())
        let chart = naviController(image: UIImage(systemName: "chart.bar"), title: "차트", rootViewController: ChartViewController())
        let num = naviController(image: UIImage(systemName: "number.circle"), title: "번호 추첨", rootViewController: RandomMoneyViewController())
        
        self.viewControllers = [ calendar, home, lotto, chart, num ]
    }
    
    func naviController(image: UIImage!, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let navi = UINavigationController(rootViewController: rootViewController)
        navi.tabBarItem.title = title
        navi.tabBarItem.image = image.withTintColor(.white)
        return navi
    }
}
