//
//  CellModel.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/08/09.
//

import Foundation

class CellModel {
    let jpName: String
    let enName: String
    let direction: String
    let starIconURL: URL?
    var imageData: Data? = nil

    init(
        jpName: String,
        enName: String,
        direction: String,
        starIconURL: URL?
       
    ) {
        self.jpName = jpName
        self.enName = enName
        self.direction = direction
        self.starIconURL = starIconURL
    }
}
