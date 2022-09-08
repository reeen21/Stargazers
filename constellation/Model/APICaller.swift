///
//  APICaller.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getInfo(latitude: Double, longitude: Double, completion: @escaping (Result<[Results], Error>) -> Void) {
        let dt = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH mm"
        let date = dateFormatter.string(from: dt)
        let separate = date.components(separatedBy: " ")
        let MonthAndDay = separate[0]
        let hour = separate[1]
        let min = separate[2]

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let url = "https://livlog.xyz/hoshimiru/constellation?lat=\(latitude)&lng=\(longitude)&date=\(MonthAndDay)&hour=\(hour)&min=\(min)"
        guard let urlString = URL(string: url) else {return}
        URLSession.shared.dataTask(with: urlString) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try decoder.decode(Articles.self, from: data)
                    completion(.success(result.result))
                } catch {
                    completion(.failure(error))
                    print("getInfo()でエラーが発生", error)
                }
            }
        }.resume()        
    }
}
