//
//  ViewController.swift
//  Test_practice
//
//  Created by Sunny on 2023/07/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        run()
    }

    func run() {
        for caseEnum in [Test.test1, Test.test2, Test.test3] {
            let rawValue = caseEnum
            let size = MemoryLayout.size(ofValue: rawValue)
            print("\(caseEnum): \(rawValue), Memory Size: \(size) bytes")
        }
    }
}

enum Test: Int {
    case test1
    case test2
    case test3
}


