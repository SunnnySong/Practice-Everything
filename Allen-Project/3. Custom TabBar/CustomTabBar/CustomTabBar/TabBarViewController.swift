//
//  TabBarViewController.swift
//  CustomTabBar
//
//  Created by 송선진 on 2022/10/11.
//

import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateTabBar()
        setupTabBar()
    }
    
    // MARK: - Helpers

    private func generateTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        
        // MARK: - ver. 1)

//        let home = UINavigationController(rootViewController: HomeController())
//        let second = UINavigationController(rootViewController: SecondViewController())
//        let third = UINavigationController(rootViewController: ThirdViewController())
//        let lotto = UINavigationController(rootViewController: LottoViewController())
//        let fourth = UINavigationController(rootViewController: FourthViewController())
//
//        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
//        let secondItem = UITabBarItem(title: "Second", image: UIImage(systemName: "calendar.badge.plus"), tag: 1)
//        let thirdItem = UITabBarItem(title: "Third", image: UIImage(systemName: "chart.bar"), tag: 2)
//        let lottoItem = UITabBarItem(title: "로또 QR", image: UIImage(systemName: "qrcode"), tag: 3)
//        let fourthItem = UITabBarItem(title: "Fourth", image: UIImage(systemName: "number.circle"), tag: 4)
//
//        home.tabBarItem = homeItem
//        second.tabBarItem = secondItem
//        third.tabBarItem = thirdItem
//        lotto.tabBarItem = lottoItem
//        fourth.tabBarItem = fourthItem
        
        // MARK: - ver. 2)

        let home = NVController(image: UIImage(systemName: "house"), title: "Home", rootViewController: HomeController())
        let second = NVController(image: UIImage(systemName: "calendar.badge.plus"), title: "Second", rootViewController: SecondViewController())
        let third = NVController(image: UIImage(systemName: "chart.bar"), title: "Third", rootViewController: ThirdViewController())
        let lotto = NVController(image: UIImage(systemName: "qrcode"), title: "로또 QR", rootViewController: LottoViewController())
        let fourth = NVController(image: UIImage(systemName: "number.circle"), title: "Fourth", rootViewController: FourthViewController())
        
        // UINavigationController의 하위클래스에 viewControllers 존재,
        // viewControllers : An array of the root view controllers displayed by the tab bar interface. 즉, UINavigationController가 관리할 view controllers들
        self.viewControllers = [ home, second, lotto, third, fourth]
        
    }
    
    private func setupTabBar() {
        
    }
    
    func NVController(image: UIImage!, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
//        nav.navigationBar.tintColor = .black
        return nav
    }
    
    
}
