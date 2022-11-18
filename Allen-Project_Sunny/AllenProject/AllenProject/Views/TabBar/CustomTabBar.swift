//
//  CustomTabBar.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/18.
//

import UIKit

class CustomTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = UIColor(hex: "202632")

        self.standardAppearance = tabBarAppearance
        self.scrollEdgeAppearance = tabBarAppearance
        self.tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
