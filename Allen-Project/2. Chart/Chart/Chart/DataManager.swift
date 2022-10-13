//
//  ManageData.swift
//  Chart
//
//  Created by 송선진 on 2022/10/12.
//

import UIKit
import Charts


final class DataManager {
    
    var entries: [BarChartDataEntry] = []
    
    func setData() -> [BarChartDataEntry] {
        entries = MoneyData.dataEntriesForMonth(year: 2019, moneyData: MoneyData.rowData)
        return entries
    }
    
    func formatDataSet() -> BarChartData {
        let dataEntry = setData()
        let minus = dataEntry.filter { $0.y < 0 }
        let plus = dataEntry.filter { $0.y > 0 }

        let minusSet = BarChartDataSet(entries: minus)
        let plusSet = BarChartDataSet(entries: plus)
        minusSet.label = nil
        plusSet.label = nil

        minusSet.colors = [ NSUIColor(hex: "#A8C8F9") ]
        plusSet.colors = [ NSUIColor(hex: "#FC9EBD") ]

        let data = BarChartData(dataSets: [minusSet, plusSet])
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
