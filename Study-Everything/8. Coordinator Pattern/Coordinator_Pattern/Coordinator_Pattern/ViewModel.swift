//
//  ViewModel.swift
//  Coordinator_Pattern
//
//  Created by Sunny on 2023/06/26.
//

import Foundation
import Combine

class ViewModel {
    
    // @Published 를 통해 구독이 가능하도록 설정
    @Published var text: String = ""
    
}
