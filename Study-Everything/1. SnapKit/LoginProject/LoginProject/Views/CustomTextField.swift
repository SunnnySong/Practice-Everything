//
//  CustomTextField.swift
//  LoginProject
//
//  Created by 송선진 on 2022/10/05.
//

import UIKit
import SnapKit


// UIView에다가 올리는 이유는, InfoLabel, TextField를 둘 다 눌러도 반응하게 만들어야 하기 때문.
class CustomTextFieldView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .darkGray
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextField: UITextField {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        frame.size.height = 48
        backgroundColor = .clear
        textColor = .white
        keyboardType = .emailAddress
        
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// attributedPlaceholder 대신 UILabel을 사용하는 이유는, textFieldView가 클릭되었을 때 사라지는 것이 아니라 계속 남아 있기 때문. attributedPlaceholder은 no text일 때에만 존재.
class CustomInfoLabel: UILabel {
    
    init(info: String) {
        super.init(frame: .zero)
        
        text = info
        font = UIFont.systemFont(ofSize: 18)
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
