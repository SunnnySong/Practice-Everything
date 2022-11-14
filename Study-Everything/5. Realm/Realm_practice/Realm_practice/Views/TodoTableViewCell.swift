//
//  TableViewCell.swift
//  Realm_practice
//
//  Created by 송선진 on 2022/10/31.
//

import UIKit
import RealmSwift

class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellStatusButton: UIButton!
    @IBOutlet weak var cellTextField: UITextField!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // cell 선택시 회색 색깔 없애기
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        // cellStatusButton 짧게 클릭하며 menu 나오고, v 표시 사용
        cellStatusButton.changesSelectionAsPrimaryAction = true
        cellStatusButton.showsMenuAsPrimaryAction = true
        cellStatusButton.tintColor = .clear
        
        cellStatusButton.clipsToBounds = true
        cellStatusButton.layer.cornerRadius = 30 / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        //    required init?(coder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented, \(coder)")
        //    } 이 코드 대신 쓰면 error 어디서 났는지 자세히 알 수 있음.
    }
}

