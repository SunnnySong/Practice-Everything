//
//  ChartMarkerView.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import UIKit
import Charts
import SnapKit

class ChartMarkerView: MarkerView {
   
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMarkerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMarkerView() {
        
        // Xib 파일과 연결하기
        Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)
        // contentView 위에 markerBoard 위에 label 올림
        self.addSubview(baseView)
        
        baseView.layer.cornerRadius = 5
        baseView.clipsToBounds = true
        
        // TODO: offset 맞춰야함.
        self.offset = .init(x: -(baseView.frame.width / 2), y: -(baseView.frame.height + 3))
        
    }
}
