//
//  ManageData.swift
//  Chart
//
//  Created by 송선진 on 2022/10/12.
//

import UIKit
import Charts


final class DataManager {
    
    func setChartDataSet(completionHandler: ([BarChartDataSet]) -> [BarChartDataSet]) -> [BarChartDataSet] {
        let entries = MoneyData.dataEntriesForMonth(year: 2019, moneyData: MoneyData.rowData)

        let minus = entries.filter { $0.y < 0 }
        let plus = entries.filter { $0.y > 0 }

        let minusSet = BarChartDataSet(entries: minus)
        let plusSet = BarChartDataSet(entries: plus)
        
        let dataSets = completionHandler(formatDataSet(minusSet: minusSet, plusSet: plusSet))
        
        return dataSets
    }

    func formatDataSet(minusSet: BarChartDataSet, plusSet: BarChartDataSet) -> [BarChartDataSet] {
        // 마이너스면 파란색바, 플러스면 분홍색바
        minusSet.colors = [ NSUIColor(hex: "#A8C8F9") ]
        plusSet.colors = [ NSUIColor(hex: "#FC9EBD") ]
        
        // 색깔 별 바가 무엇을 의미하는지 Label
        // [ViewController.swift] chartView.legend.enasbled = false로 막아둠.
//        minusSet.label = nil
//        plusSet.label = nil
        
        // bar 위 숫자 설정
//        minusSet.valueColors = [ NSUIColor.red ]
        minusSet.drawValuesEnabled = true
        
        // bar 위의 숫자 formatter 설정 -> 근데 안됌. 왜?
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//        formatter.locale = Locale(identifier: "ko-KR")
//        minusSet.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
        return [ minusSet, plusSet ]
    }

    func setChartData() -> BarChartData {
        let chartData = setChartDataSet { $0 }
        let data = BarChartData(dataSets: chartData)
        
        return data
    }
}

// HEX color를 #0000 이런식으로 바로 쓸 수 있도록 extension
extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
