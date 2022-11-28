//
//  LottoListHeader.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/28.
//

import UIKit
import SnapKit

// collectionView에서 header : UICollectionReusableView
class LottoListHeader: UIView {
    
    let DateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDataLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDataLabel() {
        self.addSubview(DateLabel)
        
        DateLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        DateLabel.text = "안녕?"
        DateLabel.textColor = .white
    }
}
