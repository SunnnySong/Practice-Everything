//
//  TabBar.swift
//  CustomTabBar
//
//  Created by 송선진 on 2022/10/12.
//

import UIKit

class CustomTabBar: UITabBar {
    
    override func layoutSubviews() {
        // ㅎㅎ.. 이걸 안써서 존나 고생함.
        super.layoutSubviews()
        
        self.backgroundColor = .white
        self.tintColor = .black
    }
    
    // MARK: - Actions
    
    // UITabBar 범위 이상으로 버튼이 있을 때, UITabBar 범위에 벗어난 버튼도 눌릴 수 있도록 hitTest()
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    // MARK: - HitTest
//   override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//       guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
//
//       return self.middleButton.frame.contains(point) ? self.middleButton : super.hitTest(point, with: event)
//   }
}
