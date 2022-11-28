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
    
//    weak var datePickerViewDelegate: DatePickerViewDelegate?
    let lottoListViewModel = LottoListViewModel()
    let getPickerDays = LottoListViewModel().getPickerDays()
    
    var selectedYear: String = ""
    var selectedMonth: String = ""
    
    let datePickerView = UIPickerView()

    let dateTextField: UITextField = {
        let tf = UITextField()
        // 커서 깜빡이는 것 없애기
        tf.tintColor = .clear
        tf.textColor = .blue
        tf.font = .systemFont(ofSize: 17, weight: .bold)
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDateTextField()
        setupDateTextFieldAttribute()
        
        setupPickerView()
        setupPickerToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDateTextField() {
        self.addSubview(dateTextField)
        
//        dateTextField.addTarget(nil, action: #selector(DateTextFieldAction), for: .touchUpInside)
        
        dateTextField.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
    }
    
    private func setupDateTextFieldAttribute() {
        // 맨 처음 로드될때, LottoListView는 현재 날짜 기준 정렬
        self.selectedYear = lottoListViewModel.getTodayDate()[0]
        self.selectedMonth = lottoListViewModel.getTodayDate()[1]
        
        let monthText = NSMutableAttributedString(string: "\(self.selectedYear)년  \(self.selectedMonth)월 ")
        
        // 2022년 : 흰색에 글씨 크게, 더 굵게
        monthText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: self.selectedYear.count + 1))
        monthText.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .heavy), range: NSRange(location: 0, length: self.selectedYear.count + 1))
        
        // TODO: image 추가 안됌. >
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(systemName: "chevron.right")
//        monthText.append(NSAttributedString(attachment: imageAttachment))
//        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 10, height: 10))
//        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.blue)
        dateTextField.attributedText = monthText
//        dateTextField.rightView = imageView
    }

    @objc private func DateTextFieldAction() {
//        self.datePickerViewDelegate?.didSelectedDate()
        print("LottoListHeader) 클릭")
    }
    
    private func setupPickerView() {
        dateTextField.inputView = datePickerView
        datePickerView.dataSource = self
        datePickerView.delegate = self
    }
    
    private func setupPickerToolBar() {

        let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 35))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancleAction))
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        
        // cancle과 done 버튼 사이 space 주기
        let spacingBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([cancelBtn, spacingBtn, doneBtn], animated: true)
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func cancleAction() {
        print("cancle")
        self.endEditing(true)
    }
    
    @objc func doneAction() {
        print("done")
    }
}

// PickerViewDataSource
extension LottoListHeader: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getPickerDays[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return getPickerDays[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let years =  getPickerDays[0][pickerView.selectedRow(inComponent: 0)]
        let months = getPickerDays[1][pickerView.selectedRow(inComponent: 1)]
        print(years, months)
        self.selectedYear = years
        self.selectedMonth = months
    }
}

// delegate까지 설정해줘야 picker의 title이 보임.
extension LottoListHeader: UIPickerViewDelegate {
}
