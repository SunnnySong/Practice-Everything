//
//  UICollectionViewCell+.swift
//  InfiniteCalendar
//
//  Created by Sunny on 2023/08/08.
//

import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
