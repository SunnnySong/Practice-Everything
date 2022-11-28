//
//  LottoListViewModel.swift
//  AllenProject
//
//  Created by 송선진 on 2022/11/28.
//

import UIKit

class LottoListViewModel {
    
    typealias GoalResult = LottoListDataSourceController.GoalResult
    
    // rowData에서 특정 월 데이터 뽑아내기
    func getMonthList(month: Double) -> LottoItem {
        let rowData = LottoItem.rowData
        let monthData = rowData.filter { $0.buyMonth == month }
        return monthData[0]
    }
    
    // 특정 월의 당첨 퍼센테이지 구하기
    func getMonthPercent(month: Double) -> [GoalResult : Int] {
        let monthData = self.getMonthList(month: month)
        var result = GoalResult.percent
        let goalAmount = monthData.goalAmount
        let buyAmount = monthData.buyAmount
        let winAmount = monthData.winAmount
        let percent = ((winAmount - buyAmount) / buyAmount) * 100
        
        if Int(goalAmount) >= Int(buyAmount) {
            result = .success
        } else {
            result = .fail
        }
        return [result : Int(percent)]
    }
    
    // 오늘 날짜 구하기
    func getTodayDate() -> [String] {
        let yearFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        monthFormatter.dateFormat = "MM"
        
        let date = Date()
        let thisYear = yearFormatter.string(from: date)
        let thisMonth = monthFormatter.string(from: date)
        return [ thisYear, thisMonth ]
    }
    
    // datePicker 구현시, 년도(1년부터 오늘 년도까지)와 월 설정
    func getPickerDays() -> [[String]] {
        var year: [String] = []
        let month = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]
        guard let thisYear = Int(self.getTodayDate()[0]) else { return []}
        for num in stride(from: thisYear, to: 1, by: -1) {
            year.append(String("\(num)년"))
        }
        return [year, month]
    }
}

// TODO: delegate와 연결해서 pickerView 띄우기
// delegate protocol 설정할때, AnyObject 명시하면 weak 사용으로 Memory Leak문제 해결 가능
protocol DatePickerViewDelegate: AnyObject {
    func didSelectedDate()
}
