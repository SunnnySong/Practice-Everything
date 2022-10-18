//
//  CalendarCell.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/18.
//

import UIKit
import FSCalendar

class CalendarCell: FSCalendarCell {

    weak var circleImageView: UIImageView!
    weak var selectionLayer: CAShapeLayer!
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
}
