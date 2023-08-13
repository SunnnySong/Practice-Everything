//
//  DayComponent.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/08.
//

import Foundation

struct DayComponent: Hashable {

    let date: Date
    let isIncludeInMonth: Bool
}

extension DayComponent {

    var number: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"

        return formatter.string(from: date)
    }
}
