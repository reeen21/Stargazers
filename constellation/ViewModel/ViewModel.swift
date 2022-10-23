//
//  ViewModel.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/10/23.
//

import Foundation

class ViewModel {
    private var result = [Results]()
    private var cellModel = [CellModel]()

    func apiCaller(lati: Double, log: Double, completion: @escaping ([Results], [CellModel]) -> Void) {
        APICaller.shared.getInfo(latitude: lati, longitude: log) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.result = articles
                self?.cellModel = articles.compactMap({
                    CellModel(
                        jpName: $0.jpName,
                        enName: $0.enName,
                        direction: $0.direction,
                        starIconURL: $0.starIconURL)
                })
                completion(self!.result, self!.cellModel)

            case .failure(let err):
                print("検索時にerrorが発生しました:\(err)")
            }
        }
    }
}
