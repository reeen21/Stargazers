//
//  Cell.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/06.
//

import UIKit

class ConstellationCell: UITableViewCell {
    
    @IBOutlet var constellationName: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var starIcon: UIImageView!

    func configure(with cellModel: CellViewModel) {
        constellationName.text = "\(cellModel.jpName) / \(cellModel.enName)"
        directionLabel.text = "方角: \(cellModel.direction)"
        
        constellationName.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .bold)
        directionLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        
        constellationName.textColor = .systemRed
        directionLabel.textColor = .systemRed
        
        starIcon.layer.cornerRadius = 35
<<<<<<< HEAD
        let imageUrl = cellModel.starIconURL
=======
        //let imageUrl = cellModel.starIconURL
>>>>>>> refs/remotes/origin/main
       // Nuke.loadImage(with: imageUrl, into: starIcon)
    }
}
