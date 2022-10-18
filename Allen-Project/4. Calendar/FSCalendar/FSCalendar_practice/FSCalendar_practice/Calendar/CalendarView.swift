//
//  Calendar.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/18.
//

import UIKit
import FSCalendar
import SnapKit

class CalendarView: FSCalendar {
    
    enum extensionNum {
        case up
        case down
    }
    
    var extensionState = extensionNum.down
    
    // MARK: - Properties
    
    private lazy var extensionButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleExtensionBtn), for: .touchUpInside)
        return button
    }()

    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        extensionState = .down
        configuareCal()
        configuareExtensionBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    func configuareCal() {
        delegate = self
        addSubview(extensionButton)
        
        backgroundColor = UIColor(hex: "5294F9", alpha: 0.12)
        layer.cornerRadius = 20
        clipsToBounds = true
        
        // 주간 / 월간 모드
//        scope = .week
        
        // header
        // header 에 흐릿하게 보이는 년, 월 없애기
        appearance.headerDateFormat = "YYYY년 MM월"
        appearance.headerMinimumDissolvedAlpha = 0
//        appearance.headerTitleAlignment = .left
    }
    
    func configuareExtensionBtn() {
        // 확장 화살표 넣기 위한 bottom 공간 확보
        self.collectionViewLayout.sectionInsets.bottom = 25
        
        // autoLayout
        extensionButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func handleExtensionBtn() {
        if extensionState == .down {
            extensionState = .up
            self.setScope(.week, animated: true)
            extensionButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        } else {
            extensionState = .down
            self.setScope(.month, animated: true)
            extensionButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
    }
}

extension CalendarView: FSCalendarDelegate {
    // Calendar 주간, 월간 원활한 크기 변화를 위해
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
            // Do other updates
        }
        self.superview?.layoutIfNeeded()
    }
}
