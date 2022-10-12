//
//  ManageData.swift
//  Chart
//
//  Created by 송선진 on 2022/10/12.
//

import Foundation
import Charts


final class DataManager {
    
    let createData = CreateData().data
    
    func setData() -> BarChartData {
        let set = BarChartDataSet(entries: createData, label: "Lotto Money")
        let data = BarChartData(dataSet: set)
        return data
    }
}
