//
//  Cell.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import UIKit
import Nuke

class ConstellationCell: UITableViewCell {
    
    @IBOutlet weak var constellationName: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var starIcon: UIImageView!

    func configure(with cellModel: CellModel) {
        constellationName.text = "\(cellModel.jpName) / \(cellModel.enName)"
        directionLabel.text = "方角: \(cellModel.direction)"
        
        constellationName.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .bold)
        directionLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        
        constellationName.textColor = .systemRed
        directionLabel.textColor = .systemRed
        
        starIcon.layer.cornerRadius = 35
        let imageUrl = cellModel.starIconURL
        Nuke.loadImage(with: imageUrl, into: starIcon)
    }
}
