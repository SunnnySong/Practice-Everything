//
//  TabBarViewController.swift
//  CustomTabBar
//
//  Created by 송선진 on 2022/10/11.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // 버튼에 이미지,텍스트 세로로 정렬하기
    lazy var middleButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        var titleAttr = AttributedString.init("로또 QR")
        titleAttr.font = .systemFont(ofSize: 13, weight: .bold)
        config.attributedSubtitle = titleAttr
        config.titleAlignment = .center

        let image = UIImage(systemName: "qrcode")
        config.image = image
        config.imagePadding = 5
        config.imagePlacement = .top

        return UIButton(configuration: config)
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TabBarController에 TabBar connect 코드
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        
        generateTabBar()
        generateMiddleButton()
    }
    
    // MARK: - Helpers
    
    private func generateMiddleButton() {
        tabBar.addSubview(middleButton)

        middleButton.frame = CGRect(x: tabBar.center.x - 45, y: -45, width: 90, height: 90)
        middleButton.layer.cornerRadius = 45
        middleButton.clipsToBounds = true
        middleButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
    }
    
    @objc func menuButtonAction() {
        // selectedIndex: The index of the view controller associated with the currently selected tab item. (현재 선택된 tabItem의 index)
        self.selectedIndex = 2
        // 여기서 selectedIndex는 viewController의 순서에 따라 lotto 지칭.
    }
    
    private func generateTabBar() {
        // MARK: - ver. 1)
        
        //        let home = UINavigationController(rootViewController: HomeController())
        //        let second = UINavigationController(rootViewController: SecondViewController())
//                let third = UINavigationController(rootViewController: ThirdViewController())
//                let lotto = UINavigationController(rootViewController: LottoViewController())
//                let fourth = UINavigationController(rootViewController: FourthViewController())
        //
        //        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        //        let secondItem = UITabBarItem(title: "Second", image: UIImage(systemName: "calendar.badge.plus"), tag: 1)
//                let thirdItem = UITabBarItem(title: "Third", image: UIImage(systemName: "chart.bar"), tag: 2)
//                let lottoItem = UITabBarItem(title: "로또 QR", image: UIImage(systemName: "qrcode"), tag: 3)
//                let fourthItem = UITabBarItem(title: "Fourth", image: UIImage(systemName: "number.circle"), tag: 4)
        //
        //        home.tabBarItem = homeItem
        //        second.tabBarItem = secondItem
//                third.tabBarItem = thirdItem
//                lotto.tabBarItem = lottoItem
//                fourth.tabBarItem = fourthItem
        
        // MARK: - ver. 2)
        
        let home = naVController(image: UIImage(systemName: "house"), title: "Home", rootViewController: HomeController())
        let second = naVController(image: UIImage(systemName: "calendar.badge.plus"), title: "Second", rootViewController: SecondViewController())
        let third = naVController(image: UIImage(systemName: "chart.bar"), title: "Third", rootViewController: ThirdViewController())
        let lotto = naVController(image: UIImage(systemName: "qrcode"), title: "", rootViewController: LottoViewController())
        let fourth = naVController(image: UIImage(systemName: "number.circle"), title: "Fourth", rootViewController: FourthViewController())
        
        
        // UINavigationController의 하위클래스에 viewControllers 존재,
        // viewControllers : An array of the root view controllers displayed by the tab bar interface. 즉, UINavigationController가 관리할 view controllers들
        self.viewControllers = [ home, second, lotto, third, fourth]
    }
    
    func naVController(image: UIImage!, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
}

