//
//  Model.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

// String 형태의 rowdata를 가공한, 이 앱에서 핵심 데이터인 Date()형태의 데이터
struct Model {
    // 서버에서 UtcTimeModel로 수많은 데이터를 가져왔지만, 이 앱에서는 그 중 하나인 currentDateTime만 사용.
    var currentDateTime: Date
}
