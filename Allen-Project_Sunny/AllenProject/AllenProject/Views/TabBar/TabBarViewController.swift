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
        
        tabBarConfigure()
        setupTabBar()
    }
    
    private func tabBarConfigure() {
        setValue(CustomTabBar(frame: tabBar.frame), forKey: "tabBar")
        
        delegate = self
    }
    
    private func setupTabBar() {
        
        let calendar = naviController(image: UIImage(systemName: "calendar.badge.plus"), title: "달력", rootViewController: DateViewController())
        let home = naviController(image: UIImage(systemName: "house"), title: "홈", rootViewController: HomeViewController())
        let chart = naviController(image: UIImage(systemName: "chart.bar"), title: "차트", rootViewController: ChartViewController())
        let num = naviController(image: UIImage(systemName: "number.circle"), title: "번호 추첨", rootViewController: RandomMoneyViewController())
        
        self.viewControllers = [ calendar, home, UIViewController() , chart, num ]
        
        /*
         참조 : https://keyhan-kam.medium.com/tabbar-with-raised-middle-button-swift-132ab62c7911
         customTabBar.middleBtnActionHandler = {
            print("moving")
            // self.navigationController?.pushViewController(LottoViewController(), animated: true)
            self.selectedIndex = 2
         }
         이런식으로 middleBtn을 클릭했을시 action을 처리하려 했는데, CustomTabBar까지는 작동이 되는데 TabBarViewController로 넘어오지 않았음.
         이유는 왜인지 모르겠지만 아래와 같이 실행해줘야 가능.
         */
        guard let tabBar = self.tabBar as? CustomTabBar else { return }
        tabBar.middleBtnActionHandler = {
            print("clicked")
//            self.selectedIndex = 2
            self.navigationController?.pushViewController(LottoViewController(), animated: true)
        }
    }
    
    func naviController(image: UIImage!, title: String, rootViewController: UIViewController) -> UINavigationController {
        
        let navi = UINavigationController(rootViewController: rootViewController)
        navi.tabBarItem.title = title
        navi.tabBarItem.image = image.withTintColor(.white)
        return navi
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    /*
     middleButton은 tabBar item[2]의 구역에 존재하지만, 포함되지 않는 부분도 존재.
     hitTest로 middleButton 전역이 눌릴 수 있도록 구현했으니, middleButton이 아닌 tabBar item[2]의 부분이 눌리지 않도록 tabBar item[2]를 비활성화 시킴.(select을 false로)
     */
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        if selectedIndex == 2 {
            return false
        }
        return true
    }
}
