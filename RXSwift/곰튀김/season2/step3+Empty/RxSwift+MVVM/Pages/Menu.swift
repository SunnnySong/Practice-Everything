//
//  Menu.swift
//  RxSwift+MVVM
//
//  Created by 송선진 on 2022/10/28.
//  Copyright © 2022 iamchiwon. All rights reserved.
//

import Foundation

// ViewModel : View를 위한 Model
// MenuList에 나올 메뉴들의 이름, 가격, 개수 Model
struct Menu {
    var id: Int
    var name: String
    var price: Int
    var count: Int
}

extension Menu {
    static func fromMenuItems(id: Int, item: MenuItem) -> Menu {
        return Menu(id: id, name: item.name, price: item.price, count: 0)
    }
}
