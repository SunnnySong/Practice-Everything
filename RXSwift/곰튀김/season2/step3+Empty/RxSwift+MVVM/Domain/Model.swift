//
//  Model.swift
//  RxSwift+MVVM
//
//  Created by iamchiwon on 07/08/2019.
//  Copyright © 2019 iamchiwon. All rights reserved.
//

import Foundation

// 서버에서 받아오는 데이터 타입
struct MenuItem: Decodable {
    var name: String
    var price: Int
}
