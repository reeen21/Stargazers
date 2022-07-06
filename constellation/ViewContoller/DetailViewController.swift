//
//  ViewController.swift
//  constellation
//
//  Created by 高橋蓮 on 2022/07/05.
//

import UIKit
import CoreLocation
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var starIconImageView: UIImageView!
    @IBOutlet var altitudeNumLabel: UILabel!
    @IBOutlet var directionLabel: UILabel!
    @IBOutlet var directionNumLabel: UILabel!
    @IBOutlet var seasonLabel: UILabel!
    @IBOutlet var nowDirection: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var jpNameLabel: UILabel!
    @IBOutlet var originLabel: UITextView!
    @IBOutlet var contentLabel: UITextView!
    
    var results: Results!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setData()
    }
    
    func setData() {
        let result = results!
        altitudeNumLabel.text = "高度: \(result.altitudeNum)°"
        contentLabel.text = "概説: \(result.content)"
        directionNumLabel.text = "方角(°)\(result.directionNum)"
        directionLabel.text = "方角: \(result.direction)"
        seasonLabel.text = "季節: \(result.season)"
        jpNameLabel.text = "\(result.jpName) / \(result.jpName)"
        originLabel.text = "起源: \(result.origin)"
        altitudeLabel.text = result.altitude
        nowDirection.text = "今の方角"
        
        altitudeNumLabel.textColor = .white
        altitudeLabel.textColor = .white
        directionLabel.textColor = .white
        nowDirection.textColor = .white
        jpNameLabel.textColor = .white
        directionNumLabel.textColor = .white
        seasonLabel.textColor = .white
        originLabel.backgroundColor = .clear
        originLabel.textColor = .white
        contentLabel.backgroundColor = .clear
        contentLabel.textColor = .white
        
        let starImageUrl = result.starImageURL
        starImageView.layer.borderWidth = 0.3
        starImageView.layer.borderColor = UIColor.darkGray.cgColor
        Nuke.loadImage(with: starImageUrl, into: starImageView)
        
        let starIconUrl = result.starIconURL
        starIconImageView.layer.borderWidth = 0.3
        starIconImageView.layer.borderColor = UIColor.darkGray.cgColor
        Nuke.loadImage(with: starIconUrl, into: starIconImageView)
    }
}
