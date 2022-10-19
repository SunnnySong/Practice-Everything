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
}


struct LottoDataWithDate {
    var buyDate: Date
    var lottoType: LottoType
    var lottoAmount: Int
}
