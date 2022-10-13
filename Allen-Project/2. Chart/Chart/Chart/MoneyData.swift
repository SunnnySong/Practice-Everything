//
//  ChartData.swift
//  Chart
//
//  Created by 송선진 on 2022/10/12.
//

import Foundation
import Charts


struct MoneyData {
    var year: Int
    var month: Double
    var money: Double
    
    static var monthLabel = ["", "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    
    static var rowData: [MoneyData] = [
        
        MoneyData(year: 2019, month: 1, money: -50000),
        MoneyData(year: 2019, month: 2, money: 200000),
        MoneyData(year: 2019, month: 3, money: -11500),
        MoneyData(year: 2019, month: 4, money: 70000),
        MoneyData(year: 2019, month: 5, money: -80000),
        MoneyData(year: 2019, month: 6, money: 10000),
        MoneyData(year: 2019, month: 7, money: -50000),
        MoneyData(year: 2019, month: 8, money: -95000),
        MoneyData(year: 2019, month: 9, money: 20000),
        MoneyData(year: 2019, month: 10, money: 50000),
        MoneyData(year: 2019, month: 11, money: -50000),
        MoneyData(year: 2019, month: 12, money: -30000),
        
        MoneyData(year: 2020, month: 1, money: -50000),
        MoneyData(year: 2020, month: 2, money: 200000),
        MoneyData(year: 2020, month: 3, money: -11500),
        MoneyData(year: 2020, month: 4, money: 70000),
        MoneyData(year: 2020, month: 5, money: -80000),
        MoneyData(year: 2020, month: 6, money: 100000),
        MoneyData(year: 2020, month: 7, money: -50000),
        MoneyData(year: 2020, month: 8, money: -95000),
        MoneyData(year: 2020, month: 9, money: 20000),
        MoneyData(year: 2020, month: 10, money: 50000),
        MoneyData(year: 2020, month: 11, money: -50000),
        MoneyData(year: 2020, month: 12, money: -30000),
        
        MoneyData(year: 2021, month: 1, money: -50000),
        MoneyData(year: 2021, month: 2, money: 200000),
        MoneyData(year: 2021, month: 3, money: -11500),
        MoneyData(year: 2021, month: 4, money: 70000),
        MoneyData(year: 2021, month: 5, money: -80000),
        MoneyData(year: 2021, month: 6, money: 100000),
        MoneyData(year: 2021, month: 7, money: -50000),
        MoneyData(year: 2021, month: 8, money: -95000),
        MoneyData(year: 2021, month: 9, money: 20000),
        MoneyData(year: 2021, month: 10, money: 50000),
        MoneyData(year: 2021, month: 11, money: -50000),
        MoneyData(year: 2021, month: 12, money: -30000)
    ]
    
    static func dataEntriesForMonth(year: Int, moneyData: [MoneyData]) -> [BarChartDataEntry] {
        // 년도 별 moneyData를 BarChartDataEntry로 변환하여 추출
        let monthMoneyData = moneyData.filter { $0.year == year }
        return monthMoneyData.map { BarChartDataEntry(x: $0.month, y: $0.money)}
    }

//        let rowData = [
//            "1월, -50000",
//            "2월, 200000",
//            "3월, -11500",
//            "4월, 70000",
//            "5월, -80000",
//            "6월, 100000",
//            "7월, -50000",
//            "8월, -95000",
//            "9월, 20000",
//            "10월, 50000",
//            "11월, -50000",
//            "12월, -30000"
//        ]

   
//    let data: [BarChartDataEntry] = [
//
//        BarChartDataEntry(x: 1.0, y: -50000),
//        BarChartDataEntry(x: 2.0, y: 200000),
//        BarChartDataEntry(x: 3.0, y: -11500),
//        BarChartDataEntry(x: 4.0, y: 70000),
//        BarChartDataEntry(x: 5.0, y: -80000),
//        BarChartDataEntry(x: 6.0, y: 100000),
//        BarChartDataEntry(x: 7.0, y: -50000),
//        BarChartDataEntry(x: 8.0, y: -95000),
//        BarChartDataEntry(x: 9.0, y: 20000),
//        BarChartDataEntry(x: 10.0, y: 50000),
//        BarChartDataEntry(x: 11.0, y: -50000),
//        BarChartDataEntry(x: 12.0, y: -30000)
//    ]
}
