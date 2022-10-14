//
//  CustomMarkerView.swift
//  Chart
//
//  Created by 송선진 on 2022/10/14.
//

import UIKit
import Charts



// https://medium.com/geekculture/swift-ios-charts-tutorial-highlight-selected-value-with-a-custom-marker-30ccbf92aa1b
class CustomMarkerView: MarkerView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var markerBoard: UIView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuareUI() {
        Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)
        // contentView 위에 markerBoard 위에 label 올림
        addSubview(contentView)
        
        markerBoard.layer.borderWidth = 2
        markerBoard.layer.borderColor = CGColor(gray: 0.7, alpha: 1)
        markerBoard.clipsToBounds = true
        markerBoard.layer.cornerRadius = 5
        
        self.offset = CGPoint(x: -(markerBoard.frame.width / 2), y: -(markerBoard.frame.height + 3))
    }
}
