//
//  Repository.swift
//  MVCToMVVM
//
//  Created by 송선진 on 2022/10/25.
//

import Foundation

// Entity를 불러오는 주체: Repository
// Entity를 불러오는 행위: Fetch
class Repository {
    // 서버에서 row Data를 불러오는 함수
    func fetchNow(onCompleted: @escaping (UtcTimeModel) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"
       
        // session 이용해 데이터 가져와 decoder
        URLSession.shared.dataTask(with: URL(string: url)!) { date, _, _ in
            guard let date = date else { return }
            guard let model = try? JSONDecoder().decode(UtcTimeModel.self, from: date) else { return }
            
            // completionHandler 이용하여 decode한 date를 다른 함수로 던지기.
            onCompleted(model)
        }.resume()
    }
}
