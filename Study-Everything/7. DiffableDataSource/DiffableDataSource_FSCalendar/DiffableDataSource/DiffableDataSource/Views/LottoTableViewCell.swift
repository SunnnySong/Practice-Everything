//
//  TableViewCell.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/23.
//

import UIKit
import SnapKit
import FSCalendar

class LottoTableViewCell: UITableViewCell {
    
    // MARK: - Properties

    var dateLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 15)
       return label
   }()
   
   var lottoTypeLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 20)
       return label
   }()
   
   var lottoAmountLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 25)
       return label
   }()
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // cell의 item간 간격을 주기 위해 cell.contentView.frame 당 inset 설정
        // self.frame이 아닌, contentView.frame으로 설정해야 item 간 간격이 설정되기 때문에 아래 configuareUI, autoLayout도 cell에 올리는 것이 아닌 contentView에 올렸음.
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15))
    }
    
    // MARK: - Helpers

    func setupCell() {
        contentView.backgroundColor = UIColor(hex: "fcc0ec", alpha: 0.72)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(20)
        }
        
        contentView.addSubview(lottoTypeLabel)
        lottoTypeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(5)
            make.left.equalToSuperview().inset(40)
        }
        
        contentView.addSubview(lottoAmountLabel)
        lottoAmountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lottoTypeLabel)
            make.right.equalToSuperview().inset(40)
        }
    }
}
