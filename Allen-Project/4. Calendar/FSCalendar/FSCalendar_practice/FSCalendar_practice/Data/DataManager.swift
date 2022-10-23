//
//  DataManager.swift
//  FSCalendar_practice
//
//  Created by 송선진 on 2022/10/19.
//

import UIKit
import FSCalendar

final class DataManager {
    
    // LottoData -> LottoDataWithDate
    static func changeStringToDate() -> [LottoDataWithDate] {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        
        // ver 1.
        let newData = LottoData.rowData.map { data in
            LottoDataWithDate(buyDate: dataFormatter.date(from: data.buyDate)!, lottoType: data.lottoType, lottoAmount: data.lottoAmount)
        }
        // ver 2.
//        let data = lottoData.map({ (value: LottoData) -> LottoDataWithDate in return LottoDataWithDate(buyDate: dataFormatter.date(from: value.buyDate)!, lottoType: value.lottoType, lottoAmount: value.lottoAmount)})
        return newData
    }
    
    // selectedData와 동일한 날짜의 lottoData를 리턴해주는 함수
    func findSelectedData(selectedDate: Date?) -> [LottoData] {
        guard let selectDate = selectedDate else { return [] }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: selectDate))
        
        var lottoViewData: [LottoData] = []
        
        // lottoViewData에 selectedDate와 동일한 날짜 데이터 저장
        for data in LottoData.rowData {
            if data.buyDate == dateFormatter.string(from: selectDate) {
                // rowData에서 선택한 날짜와 같은 날짜의 데이터들이 있으면 lottoViewData에 우선 담김.
                // 이렇게 한 이유는 tableViewCell을 띄울때 모든 rowData를 탐색하여 같은 날짜에 담는 것 보다 한 날짜 데이터들을 변수로 묶어 놓고, 이 안에서 for로 돌리면 되기 때문.
                lottoViewData.append(data)
                print("DataManager) lottoViewDate에 데이터 옮기기 완료 " + data.buyDate)
            }
        }
        return lottoViewData
    }
}


struct LottoDataWithDate {
    var buyDate: Date
    var lottoType: LottoType
    var lottoAmount: Int
}
