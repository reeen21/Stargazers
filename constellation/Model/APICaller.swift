///
//  APICaller.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getInfo(lat: Double, lon: Double, completion: @escaping (Result<[Results], Error>) -> Void) {
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
        //https://livlog.xyz/hoshimiru/constellation?lat=35.862&lng=139.645&date=2013-10-31&hour=0&min=0
        let url = "https://livlog.xyz/hoshimiru/constellation?lat=\(lat)&lng=\(lon)&date=\(MonthAndDay)&hour=\(hour)&min=\(min)"
        print(url)
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
