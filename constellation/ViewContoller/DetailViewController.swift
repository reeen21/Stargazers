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
    private var bigImageButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setData()
        
        bigImageButton = UIBarButtonItem(title: "大きい写真", style: .done, target: self, action: #selector(DetailImage(_:)))
        navigationItem.rightBarButtonItem = bigImageButton
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
    @objc func DetailImage(_ sender: UIBarButtonItem) {
        guard let result = results else {return}
        guard let detail = self.storyboard?.instantiateViewController(withIdentifier: "Big") as? BigImageView else {
            fatalError()
        }
        detail.starImageUrl = result.starImageURL
        detail.starIconUrl = result.starIconURL
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func setData() {
        guard let result = results else {return}
        altitudeNumLabel.text = "高度: \(result.altitudeNum)°"
        contentLabel.text = "概説: \(result.content)"
        directionNumLabel.text = "方角(°)\(result.directionNum)"
        directionLabel.text = "方角: \(result.direction)"
        seasonLabel.text = "季節: \(result.season)"
        jpNameLabel.text = "\(result.jpName) / \(result.jpName)"
        originLabel.text = "起源: \(result.origin)"
        altitudeLabel.text = result.altitude
        nowDirection.text = "今の方角"
        
        altitudeNumLabel.textColor = .darkGray
        altitudeLabel.textColor = .darkGray
        directionLabel.textColor = .darkGray
        nowDirection.textColor = .darkGray
        jpNameLabel.textColor = .darkGray
        directionNumLabel.textColor = .darkGray
        seasonLabel.textColor = .darkGray
        originLabel.backgroundColor = .clear
        originLabel.textColor = .darkGray
        contentLabel.backgroundColor = .clear
        contentLabel.textColor = .darkGray
        
        let starImageUrl = result.starImageURL
        starImageView.layer.borderWidth = 0.3
        starImageView.layer.borderColor = UIColor.lightGray.cgColor
        Nuke.loadImage(with: starImageUrl, into: starImageView)
        
        let starIconUrl = result.starIconURL
        starIconImageView.layer.borderWidth = 0.3
        starIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        Nuke.loadImage(with: starIconUrl, into: starIconImageView)
    }
}
