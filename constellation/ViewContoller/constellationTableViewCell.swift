//
//  Cell.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import UIKit

class constellationTableViewCell: UITableViewCell {
    @IBOutlet var constellationName: UILabel!
    @IBOutlet var directionLabel: UILabel!

    func configure(with cellModel: CellViewModel) {
        constellationName.text = "\(cellModel.jpName) / \(cellModel.enName)"
        directionLabel.text = cellModel.direction
        
        constellationName.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .light)
        directionLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .light)
    }
}
