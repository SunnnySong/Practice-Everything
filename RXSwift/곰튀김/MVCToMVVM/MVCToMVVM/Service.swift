//
//  Logic.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

// Entity -> Model로 변환하는 함수 포함
// 로직의 핵심 함수
class Service {
    
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date())
    
    // 서버에서 가져온 String 형태의 rowData를 이 앱에 맞게 Date 형태의 데이터로 변환
    func fetchNow(onCompleted: @escaping (Model) -> Void) {
        
        // repository.fetchNow: 서버에서 받아온 entity 데이터 그대로의 형태 던짐
        repository.fetchNow { [weak self] entity in
            // 서버에서 받아온 Date formatter
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            // entity.currentDateTime은 String -> Date 형태로 변환
            guard let now = formatter.date(from: entity.currentDateTime) else { return }

            // entity 데이터 -> Model로 변환 : 이 앱에서 사용할 핵심 데이터만 추출
            let model = Model(currentDateTime: now)
            
            // Service.currentModel에 지금 현재 시간 데이터를 넣어줌 -> moveDay에서 사용해야 하기 때문
            self?.currentModel = model
            
            // currentDateTime만 담겨져 있는 Model 던지기
            onCompleted(model)
        }
    }
    
    func moveDay(day: Int) {
        // UIKit의 Calendar을 이용해 Date형태의 currentDateTime에서 날짜를 value만큼 더하고 빼는 기능
        guard let moveDay = Calendar.current.date(byAdding: .day, value: day, to: currentModel.currentDateTime) else {
            return
        }
        currentModel.currentDateTime = moveDay
    }
    
}
