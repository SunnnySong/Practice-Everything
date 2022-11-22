//
//  ChartMarkerView.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/15.
//

import UIKit
import Charts
import SnapKit

// MarkerView가 아니라 MarkerImage로 구현 가능
class ChartMarkerView: MarkerView {
   
    // TODO: marker의 높이에 따라 chartView extraoffset 설정해주기
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var upDownImage: UIImageView!
    
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
        self.addSubview(baseView)
        
        baseView.layer.cornerRadius = 5
        baseView.clipsToBounds = true
    }
    
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        
        monthLabel.text = "\(Int(entry.x)) 월"
        moneyLabel.text = "\(Int(entry.y)) 원"
        
        if entry.y > 0 {
            upDownImage.image = UIImage(systemName: "arrowtriangle.up.fill")
            upDownImage.tintColor = .red
        } else {
            upDownImage.image = UIImage(systemName: "arrowtriangle.down.fill")
            upDownImage.tintColor = .blue
        }
    }
}
