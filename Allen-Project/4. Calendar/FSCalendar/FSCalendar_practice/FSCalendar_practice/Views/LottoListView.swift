//
//  LottoListView.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/20.
//

import UIKit
import SnapKit
import FSCalendar

class LottoListView: UIView {
    
   
    
    // MARK: - Properties
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var lottoTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var lottoAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    var selectedDate: Date = CalendarView().selectedDate ?? Date() {
        didSet {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
//            dateLabel.text = formatter.string(from: selectedDate)
            print("lottolist: \(selectedDate)")
        }
    }
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuareUI()
        autoLayout()
        showLottoList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    // MARK: - Helpers
    
    func showLottoList() {
        
    }

    func configuareUI() {
        backgroundColor = UIColor(hex: "fcc0ec", alpha: 0.72)
        layer.cornerRadius = 20
        clipsToBounds = true
        
//        dateLabel.text = "2022-10-20"
        lottoTypeLabel.text = LottoType.lotto.rawValue
        lottoAmountLabel.text = "5000 원"
    }
    
    func autoLayout() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        addSubview(lottoTypeLabel)
        lottoTypeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(5)
            make.left.equalToSuperview().inset(40)
        }
        
        addSubview(lottoAmountLabel)
        lottoAmountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lottoTypeLabel)
            make.right.equalToSuperview().inset(40)
        }
    }

}
