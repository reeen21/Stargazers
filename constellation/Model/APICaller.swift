//
//  APICaller.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import Foundation

class APICaller {
    static let shared = APICaller()
    
    func getInfo(lat: Double, lon: Double, MonthAndDay:String, hour: String, min: String, completion: @escaping (Result<[Results], Error>) -> Void) {
        let url = "https://livlog.xyz/hoshimiru/constellation?lat=\(lat)&lng=\(lon)&date=\(MonthAndDay)&hour=\(hour)&min=\(min)"
        guard let urlString = URL(string: url) else {return}
        URLSession.shared.dataTask(with: urlString) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Articles.self, from: data)
                    completion(.success(result.result))
                } catch {
                    completion(.failure(error))
                    print("getInfoでエラーが発生しました", error)
                }
            }
        }.resume()
        
    }
    
    
}
