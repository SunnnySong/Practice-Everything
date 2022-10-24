//
//  ViewModel.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

class ViewModel {
    
    var onUpdate: () -> Void = {}
    var dateTimeString = "Loding... "   // 화면에 보여지는 값, ViewModel
    {
        didSet {
            onUpdate()
        }
    }
    
    let service = Service()
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    func reload() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeString = dateString
        }
    }

    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
}
