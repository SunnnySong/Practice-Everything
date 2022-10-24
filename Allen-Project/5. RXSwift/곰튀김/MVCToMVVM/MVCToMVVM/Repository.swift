//
//  Repository.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { date, _, _ in
            guard let date = date else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: date) else { return }
            
            onCompleted(model)
        }.resume()
    }
}
