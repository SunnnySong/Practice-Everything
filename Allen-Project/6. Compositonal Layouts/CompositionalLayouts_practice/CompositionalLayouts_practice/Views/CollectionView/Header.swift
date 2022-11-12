//
//  Header.swift
//  CompositionalLayouts_practice
//
//  Created by 송선진 on 2022/11/10.
//

import UIKit
import SnapKit

class Header: UICollectionReusableView {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    
    let headerBtn: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 11
        button.layer.borderColor = CGColor(gray: 0.9, alpha: 1)
        button.layer.borderWidth = 2
        button.setTitle("더보기", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: init(text: String) 형식으로 만들어 재사용 하는 것이 아닌, prepareForReuse() 함수 사용. 이게 언제 사용하는건지 자세히 공부하기.
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        headerLabel.text = text
    }
    
    func setupHeader() {
        self.addSubview(headerBtn)
        self.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        headerBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(45)
            make.right.equalToSuperview().inset(10)
        }
    }
    
    
}
