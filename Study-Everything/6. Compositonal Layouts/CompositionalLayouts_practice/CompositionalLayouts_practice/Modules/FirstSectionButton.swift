//
//  Button.swift
//  CompositionalLayouts_practice
//
//  Created by 송선진 on 2022/11/09.
//

import Foundation
import UIKit

class FirstSectionBtn: UIButton {
    /* FirstSection.swift에서 button 3개가 같은 형식으로 이루어져 있으니 모듈 생성
     let button2: UIButton = {
         var config = UIButton.Configuration.filled()
         config.baseBackgroundColor = .gray
         
         var titleAttr = AttributedString.init("차트")
         titleAttr.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         config.attributedTitle = titleAttr
         
         var image = UIImage(systemName: "chart.line.uptrend.xyaxis")?.withTintColor(.white)
         config.image = image
         config.imagePlacement = .top
         config.imagePadding = 3
         return UIButton(configuration: config)
     }()
     */
    
    init(title: String, imageName: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .gray
        
        var titleAttr = AttributedString.init(title)
        titleAttr.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        config.attributedTitle = titleAttr
        
        let image = UIImage(systemName: imageName)?.withTintColor(.white)
        config.image = image
        config.imagePlacement = .top
        config.imagePadding = 3
        
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
