//
//  ViewModel.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

class ViewModel {
    
    let service = Service()
    
    // ViewController에서 새로 정의
    var onUpdate: () -> Void = {}
    var dateTimeString = "Loding... "   // 화면에 보여지는 값, ViewModel
    {
        didSet {
            onUpdate()
        }
    }
    
    // ViewController에서 화면에 시간을 띄우기 위해서는 Date타입의 데이터를 String타입으로 변환해야 함.
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    // ViewModel -> ViewController : ViewController에서 시간 데이터를 가져오고 싶을 때 호출
    func reload() {
        
        // service.fetchNow: currentDateTime만 담겨진 Model 던짐
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            // 화면에 띄울 수 있도록 Date형태의 데이터 -> String 변환
            let dateString = self.dateToString(date: model.currentDateTime)
            // self.dateTimeString을 변경해줌과 동시에 onUpdate() 실행 -> reload()를 실행함으로써 ViewController에서 datetimeLabel.text 값 자동 변경
            self.dateTimeString = dateString
        }
    }

    func moveDay(day: Int) {
        // service.moveDay: day만큼 +/- 한 새로 정의된 currentDateTime
        service.moveDay(day: day)
        
        // 화면에 띄우기 위한 dateTimeString변수에 새로 정의된 currentDateTime을 String형태로 변환해 저장
        dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
}
