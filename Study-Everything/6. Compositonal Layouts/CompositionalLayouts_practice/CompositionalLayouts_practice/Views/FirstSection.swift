//
//  CollectionReusableView.swift
//  CompositionalLayouts_practice
//
//  Created by 송선진 on 2022/11/08.
//

import UIKit
import SnapKit

/*
 UICollectionView 에서 header와 footer 지정 사용 가능 -> 이때 header/footer은 보충뷰(Supplementary View)로, UICollectionResuableView를 준수
 cell -> UICollectionViewCell
 header/footer-> UICollectionResuableView
 */
class FirstSection: UIView {
    
    // UIButton) image와 title 세로 정렬
    let button1 = FirstSectionBtn(title: "최신 음악", imageName: "music.mic.circle")
    
    let button2 = FirstSectionBtn(title: "차트", imageName: "chart.line.uptrend.xyaxis")
    
    let button3: FirstSectionBtn = {
        let btn = FirstSectionBtn(title: "분위기 및 장르", imageName: "face.smiling")
        btn.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [button1, button2, button3])
        // error : layout을 layoutSubviews()에서 잡기 때문에, 여기서 spacing을 잡으면 에러 발생. 
//        sv.spacing = 15
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
        stackView.spacing = 15
    }
    
    func setupHeader() {
        self.addSubview(stackView)
        
        // init()에서 layout을 잡아줄 수도 있지만, layoutSubviews()에서 .frame = bounds 로 잡아줘도 가능.
        // 단, .frame = bounds를 init()에서 한다면 작동X
//         stackView autolayout
//        stackView.snp.makeConstraints { make in
//            make.left.right.top.equalTo(self)
//        }
    }
}
